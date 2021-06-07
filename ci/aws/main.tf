variable "environment_name" {}

variable "pas_version" {}

variable "pivnet_token" {}

variable "auto_apply" {
  default = false
}

module "paasify" {
  source = "../../aws"

  env_name           = var.environment_name
  region             = "us-west-2"
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]

  dns_suffix = "aws.paasify.org"

  pas_version = var.pas_version
  tiles       = ["mysql", "rabbitmq", "redis", "scs", "sso", "metrics"]

  pivnet_token = var.pivnet_token
  auto_apply   = var.auto_apply
}