locals {
  pas_cidr      = cidrsubnet(module.pave.vpc_cidr, 4, 1)
  services_cidr = cidrsubnet(module.pave.vpc_cidr, 4, 2)
}

resource "google_compute_subnetwork" "pas" {
  name          = "${var.env_name}-pas-subnet"
  ip_cidr_range = local.pas_cidr
  network       = module.pave.network_name
  region        = var.region
}

resource "google_compute_subnetwork" "services" {
  name          = "${var.env_name}-services-subnet"
  ip_cidr_range = local.services_cidr
  network       = module.pave.network_name
  region        = var.region
}