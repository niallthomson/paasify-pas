data "aws_caller_identity" "current" {}

resource "null_resource" "infra_blocker" {
  depends_on = [
    aws_route53_record.wildcard_sys_dns,
    aws_lb_listener.web_80,
    aws_lb_listener.web_443,
    aws_lb_listener.ssh,
    aws_lb_listener.tcp,
    aws_route_table_association.route_pas_subnets,
    aws_route_table_association.route_services_subnets,
    aws_iam_user_policy_attachment.ert,
    aws_iam_access_key.pas,
  ]
}

module "pave" {
  source = "github.com/niallthomson/paasify-core//pave/aws"

  environment_name        = var.env_name
  region                  = var.region
  availability_zones      = var.availability_zones
  dns_suffix              = var.dns_suffix
  additional_cert_domains = ["*.sys", "*.apps", "*.login.sys"]
  ops_manager_version     = module.common.ops_manager_version
  ops_manager_build       = module.common.ops_manager_build
  pivnet_token            = var.pivnet_token
  director_ops_file       = data.template_file.director_ops_file.rendered

  blockers = [null_resource.infra_blocker.id]
}

resource "null_resource" "pave_blocker" {
  depends_on = [module.pave]
}

module "common" {
  source = "../common"

  pas_version        = var.pas_version
  tiles              = var.tiles
  iaas               = "light*aws"
  availability_zones = module.pave.availability_zones
  auto_apply         = var.auto_apply
  skip_smoke_tests   = var.skip_smoke_tests

  apps_domain = local.app_domain
  sys_domain  = local.sys_domain

  web_elb_names = formatlist("alb:%s", aws_lb_target_group.web_443.*.name)
  ssh_elb_names = formatlist("alb:%s", aws_lb_target_group.ssh.*.name)

  pas_ops_file   = data.template_file.pas_ops_file.rendered
  tile_ops_files = {
    "metrics" = data.template_file.metrics_ops_file.rendered
    "metric_store" = data.template_file.metric_store_ops_file.rendered
  }

  az_configuration = module.pave.az_configuration
  singleton_az     = var.availability_zones[0]

  tls_cert        = module.pave.cert_full_chain
  tls_private_key = module.pave.cert_key
  tls_ca_cert     = module.pave.cert_ca

  provisioner_host            = module.pave.provisioner_host
  provisioner_ssh_username    = module.pave.provisioner_ssh_username
  provisioner_ssh_private_key = module.pave.provisioner_ssh_private_key

  blocker = module.pave.blocker
}