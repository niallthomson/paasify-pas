provider "google" {
  region  = var.region
  project = var.project

  version = "~> 2.20.0"
}

resource "null_resource" "infra_blocker" {
  depends_on = [
    google_compute_firewall.http-lb,
    google_compute_global_forwarding_rule.https-lb-443,
  ]
}

module "pave" {
  source = "github.com/niallthomson/paasify-core//pave/gcp"

  environment_name        = var.env_name
  region                  = var.region
  availability_zones      = var.availability_zones
  project                 = var.project

  dns_suffix              = var.dns_suffix
  hosted_zone             = var.dns_zone_name

  ops_manager_version     = module.common.ops_manager_version
  ops_manager_build       = module.common.ops_manager_build

  pivnet_token            = var.pivnet_token

  additional_cert_domains = ["*.sys", "*.apps", "*.login.sys"]

  director_ops_file       = data.template_file.director_ops_file.rendered

  blockers                = [null_resource.infra_blocker.id]
}

resource "null_resource" "pave_blocker" {
  depends_on = [module.pave]
}

module "common" {
  source = "../common"

  pas_version        = var.pas_version
  tiles              = var.tiles
  iaas               = "google"
  availability_zones = module.pave.availability_zones

  apps_domain      = "${replace(replace(google_dns_record_set.wildcard-apps-dns.name, "/^\\*\\./", ""), "/\\.$/", "")}"
  sys_domain       = "${replace(replace(google_dns_record_set.wildcard-sys-dns.name, "/^\\*\\./", ""), "/\\.$/", "")}"

  web_elb_names    = ["tcp:${google_compute_target_pool.websocket-lb.name}", "http:${google_compute_backend_service.http-lb.name}"]
  ssh_elb_names    = ["tcp:${google_compute_target_pool.ssh-lb.name}"]

  pas_ops_file     = data.template_file.pas_ops_file.rendered
  
  az_configuration = module.pave.az_configuration
  singleton_az     = var.availability_zones[0]

  tls_cert         = module.pave.cert_full_chain
  tls_private_key  = module.pave.cert_key
  tls_ca_cert      = module.pave.cert_ca

  provisioner_host            = module.pave.provisioner_host
  provisioner_ssh_username    = module.pave.provisioner_ssh_username
  provisioner_ssh_private_key = module.pave.provisioner_ssh_private_key

  blocker          = module.pave.blocker
}