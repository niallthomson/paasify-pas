provider "aws" {
  region = var.region
}

data "aws_caller_identity" "current" {}

module "opsman_image" {
  source = "github.com/nthomson-pivotal/paasify-core//opsmanager-image/aws"

  om_version = "2.7.0"
  om_build   = "165"
}

module "infra" {
  source = "../paving-pas/aws/examples/open-network"

  env_name           = var.env_name

  dns_suffix         = var.dns_suffix

  access_key         = ""
  secret_key         = ""

  region             = var.region
  availability_zones = var.availability_zones
  vpc_cidr           = var.vpc_cidr

  ops_manager_ami           = module.opsman_image.ami_id
  ops_manager_instance_type = var.ops_manager_instance_type
}

locals {
  base_domain = "${var.env_name}.${var.dns_suffix}"
}

data "aws_route53_zone" "selected" {
  name = "${var.dns_suffix}."
}

module "ns_record" {
  source = "../paving-pas/aws/modules/add_ns_to_hosted_zone"

  top_level_zone_id  = data.aws_route53_zone.selected.zone_id
  zone_name          = local.base_domain
  name_servers       = module.infra.env_dns_zone_name_servers
}

resource "null_resource" "infra_blocker" {
  depends_on = [module.infra, module.ns_record]
}

module "pas_network_config" {
  source = "github.com/nthomson-pivotal/paasify-core//build-network-config/aws"

  vpc_cidr      = var.vpc_cidr
  subnet_ids    = module.infra.pas_subnet_ids
  subnet_cidrs  = module.infra.pas_subnet_cidrs
  subnet_azs    = module.infra.pas_subnet_availability_zones
}

data "template_file" "director_ops_file" {
  template = "${chomp(file("${path.module}/templates/director-ops-file.yml"))}"

  vars = {
    pas_subnets = module.pas_network_config.subnet_config
    env_name   = var.env_name
  }
}

module "setup_director" {
  source = "github.com/nthomson-pivotal/paasify-core//setup-director/aws"

  env_name                    = var.env_name
  provisioner_subnet_id       = module.infra.public_subnet_ids[0]
  dns_zone_id                 = module.infra.dns_zone_id
  pivnet_token                = var.pivnet_token
  om_host                     = module.infra.ops_manager_dns

  azs                         = var.availability_zones
  iam_instance_profile        = module.infra.ops_manager_iam_instance_profile_name
  vpc_id                      = module.infra.vpc_id
  security_group              = module.infra.vms_security_group_id
  key_pair_name               = module.infra.ops_manager_ssh_public_key_name
  ssh_private_key             = module.infra.ops_manager_ssh_private_key
  region                      = var.region
  bucket_name                 = module.infra.ops_manager_bucket
  bucket_access_key_id        = module.infra.ops_manager_iam_user_access_key
  bucket_secret_access_key    = module.infra.ops_manager_iam_user_secret_key

  vpc_cidr                    = var.vpc_cidr
  management_subnet_ids       = module.infra.infrastructure_subnet_ids
  management_subnet_cidrs     = module.infra.infrastructure_subnet_cidrs
  management_subnet_azs       = module.infra.infrastructure_subnet_availability_zones

  director_ops_file           = data.template_file.director_ops_file.rendered

  additional_cert_domains     = [module.infra.apps_domain]

  secrets = {

  }

  blocker                     = null_resource.infra_blocker.id
}

module "common" {
  source = "../common"

  iaas               = "aws"
  //additional_config  = data.template_file.resource_config.rendered

  apps_domain      = module.infra.apps_domain
  sys_domain       = module.infra.sys_domain

  web_elb_names    = formatlist("alb:%s", module.infra.web_target_groups)
  ssh_elb_names    = formatlist("alb:%s", module.infra.ssh_target_groups)

  pas_ops_file     = data.template_file.pas_ops_file.rendered
    
  az_configuration = module.setup_director.az_configuration
  singleton_az     = var.availability_zones[0]

  tls_cert         = module.setup_director.cert_full_chain
  tls_private_key  = module.setup_director.cert_key
  tls_ca_cert      = module.setup_director.cert_ca

  provisioner_host            = module.setup_director.provisioner_host
  provisioner_ssh_username    = module.setup_director.provisioner_ssh_username
  provisioner_ssh_private_key = module.setup_director.provisioner_ssh_private_key

  blocker          = module.setup_director.blocker
}