provider "google" {
  project = "fe-nthomson"
  region  = "us-central1"
}

module "paasify" {
  source = "../../gcp"

  env_name           = "test123"
  project            = "fe-nthomson"

  region             = "us-central1"
  availability_zones = ["us-central1-a", "us-central1-b", "us-central1-c"]

  dns_suffix    = "gcp.paasify.org"
  dns_zone_name = "paasify-zone"

  pas_version = "2.8"
  tiles       = ["rabbitmq"]

  pivnet_token = "mytoken123"
}