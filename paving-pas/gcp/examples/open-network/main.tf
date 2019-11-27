provider "google" {
  project     = var.project
  region      = var.region
  credentials = var.service_account_key
  # version = "~> 1.20"
}

# terraform {
#   required_version = ">= 0.12.0"
# }

module "infra" {
  source = "../../modules/infra"

  project                              = var.project
  env_name                             = var.env_name
  region                               = var.region
  infrastructure_cidr                  = var.infrastructure_cidr
  internetless                         = var.internetless
  create_blobstore_service_account_key = var.create_blobstore_service_account_key
  internal_access_source_ranges        = [var.pas_cidr, var.services_cidr]
  root_domain                          = "${var.env_name}.${var.dns_suffix}"
}

module "ops_manager" {
  source = "../../modules/ops_manager"

  project  = var.project
  env_name = var.env_name
  zones    = var.zones

  opsman_storage_bucket_count = var.opsman_storage_bucket_count

  opsman_machine_type                = var.opsman_machine_type
  opsman_image_url                   = var.opsman_image_url
  optional_opsman_image_url          = var.optional_opsman_image_url
  create_iam_service_account_members = var.create_iam_service_account_members

  pcf_network_name = module.infra.network
  subnet           = module.infra.subnet

  dns_zone_name     = module.infra.dns_zone_name
  dns_zone_dns_name = module.infra.dns_zone_dns_name

  external_database  = var.external_database
  sql_instance       = module.external_database.sql_instance
  opsman_sql_db_host = var.opsman_sql_db_host
}

module "pas_certs" {
  source = "../../modules/certs"

  subdomains    = ["*.apps", "*.sys", "*.login.sys", "*.uaa.sys"]
  env_name      = var.env_name
  dns_suffix    = var.dns_suffix
  resource_name = "pas-lbcert"

  ssl_cert           = var.ssl_cert
  ssl_private_key    = var.ssl_private_key
  ssl_ca_cert        = var.ssl_ca_cert
  ssl_ca_private_key = var.ssl_ca_private_key
}

module "pas" {
  source = "../../modules/pas"

  project            = var.project
  env_name           = var.env_name
  region             = var.region
  zones              = var.zones
  pas_cidr           = var.pas_cidr
  services_cidr      = var.services_cidr
  internetless       = var.internetless
  global_lb          = var.global_lb
  create_gcs_buckets = var.create_gcs_buckets
  buckets_location   = var.buckets_location

  network           = module.infra.network
  dns_zone_name     = module.infra.dns_zone_name
  dns_zone_dns_name = module.infra.dns_zone_dns_name
  ssl_certificate   = module.pas_certs.ssl_certificate

  isoseg_lb_name    = module.isolation_segment.load_balancer_name
  external_database = var.external_database
  sql_instance      = module.external_database.sql_instance
  pas_sql_db_host   = var.pas_sql_db_host
}

# Optional

module "isoseg_certs" {
  source = "../../modules/certs"

  subdomains    = ["*.iso"]
  env_name      = var.env_name
  dns_suffix    = var.dns_suffix
  resource_name = "isoseg-lbcert"

  ssl_cert           = var.iso_seg_ssl_cert
  ssl_private_key    = var.iso_seg_ssl_private_key
  ssl_ca_cert        = var.iso_seg_ssl_ca_cert
  ssl_ca_private_key = var.iso_seg_ssl_ca_private_key
}

module "isolation_segment" {
  source = "../../modules/isolation_segment"

  use_isolation_segment = var.isolation_segment

  env_name          = var.env_name
  zones             = var.zones
  internetless      = var.internetless
  dns_zone_dns_name = "${var.env_name}.${var.dns_suffix}"
  with_firewalls    = var.iso_seg_with_firewalls

  network                    = module.infra.network
  dns_zone_name              = module.infra.dns_zone_name
  public_health_check_link   = module.pas.cf_public_health_check
  infrastructure_subnet_cidr = var.infrastructure_cidr
  pas_subnet_cidr            = module.pas.pas_subnet_ip_cidr_range
  ssl_certificate            = module.isoseg_certs.ssl_certificate
  replicated_suffix          = var.iso_seg_replicated_suffix
}

module "external_database" {
  source = "../../modules/external_database"

  create = var.external_database

  env_name    = var.env_name
  region      = var.region
  sql_db_tier = "db-n1-standard-1"
}

module "internetless" {
  source = "../../modules/internetless"

  env_name     = var.env_name
  internetless = var.internetless
  network      = module.infra.network

  egress_target_account = module.ops_manager.service_account_email

  internal_cidr_ranges = [
    module.infra.ip_cidr_range,
    module.pas.pas_subnet_ip_cidr_range,
    module.pas.services_subnet_ip_cidr_range,
  ]
}

module "jumpbox" {
  source = "../../modules/jumpbox"

  dns_suffix        = var.dns_suffix
  availability_zone = var.zones[0]
  subnet            = module.infra.subnet

  jumpbox_init_script   = var.jumpbox_init_script
  jumpbox_public_key    = module.ops_manager.ops_manager_ssh_public_key
  jumpbox_private_key   = module.ops_manager.ops_manager_ssh_private_key
  env_name              = var.env_name
  username              = "ubuntu"
  pcf_network           = module.infra.network
  pcf_managed_zone_name = module.infra.dns_zone_name
}

