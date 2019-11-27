module "ns" {
  source = "../../modules/add_ns_to_dns_zone"

  top_level_zone_name = var.top_level_zone_id
  zone_name           = format("%s.%s.", var.env_name, var.dns_suffix)
  name_servers        = module.infra.dns_zone_name_servers
}

variable "top_level_zone_id" {
  type = string
}
