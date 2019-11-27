module "ns" {
  source = "../../modules/add_ns_to_hosted_zone"

  top_level_zone_id = var.top_level_zone_id
  zone_name         = format("%s.%s", var.env_name, var.dns_suffix)
  name_servers      = module.infra.name_servers
}

variable "top_level_zone_id" {
  type = string
}
