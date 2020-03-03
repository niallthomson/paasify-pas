provider "aws" {
  region = "us-west-2"

  version = "~> 2.50.0"
}

module "paasify" {
  source = "../../aws"

  env_name         = "test123"
  region           = "us-west-2"

  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]

  dns_suffix = "aws.paasify.org"

  pas_version = "2.8"
  tiles       = ["rabbitmq"]

  pivnet_token = "mytoken123"
}