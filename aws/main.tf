provider "aws" {
  region = var.region

  version = "~> 2.50.0"
}

data "aws_caller_identity" "current" {}

data "template_file" "director_ops_file" {
  template = "${chomp(file("${path.module}/templates/director-ops-file.yml"))}"

  vars = {
    pas_subnets        = module.pas_network_config.subnet_config
    env_name           = var.env_name
    vms_security_group = module.pave.vms_security_group_name
  }
}

module "pave" {
  source = "github.com/niallthomson/paasify-core//pave/aws"

  environment_name    = var.env_name
  region              = var.region

  availability_zones  = var.availability_zones

  dns_suffix          = var.dns_suffix

  ops_manager_version = "2.8.2"
  ops_manager_build   = "203"

  pivnet_token        = var.pivnet_token

  additional_cert_domains = ["*.sys", "*.apps", "*.login.sys"]

  director_ops_file   = data.template_file.director_ops_file.rendered
}

resource "null_resource" "pave_blocker" {
  depends_on = [module.pave]
}

module "pas_network_config" {
  source = "github.com/niallthomson/paasify-core//build-network-config/aws"

  vpc_cidr      = module.pave.vpc_cidr
  subnet_ids    = aws_subnet.pas_subnets.*.id
  subnet_cidrs  = aws_subnet.pas_subnets.*.cidr_block
  subnet_azs    = aws_subnet.pas_subnets.*.availability_zone
}

module "common" {
  source = "../common"

  iaas               = "aws"
  //additional_config  = data.template_file.resource_config.rendered

  apps_domain      = local.app_domain
  sys_domain       = local.sys_domain

  web_elb_names    = formatlist("alb:%s", aws_lb_target_group.web_443.*.name)
  ssh_elb_names    = formatlist("alb:%s", aws_lb_target_group.ssh.*.name)

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