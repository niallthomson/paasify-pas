output "cf_public_health_check" {
  value = module.gorouter.health_check_self_link
}

output "sys_domain" {
  value = replace(
    replace(google_dns_record_set.wildcard-sys-dns.name, "/^\\*\\./", ""),
    "/\\.$/",
    "",
  )
}

output "apps_domain" {
  value = replace(
    replace(
      google_dns_record_set.wildcard-apps-dns.name,
      "/^\\*\\./",
      "",
    ),
    "/\\.$/",
    "",
  )
}

output "tcp_domain" {
  value = replace(google_dns_record_set.tcp-dns.name, "/\\.$/", "")
}

output "buildpacks_bucket" {
  value = element(concat(google_storage_bucket.buildpacks.*.name, [""]), 0)
}

output "droplets_bucket" {
  value = element(concat(google_storage_bucket.droplets.*.name, [""]), 0)
}

output "packages_bucket" {
  value = element(concat(google_storage_bucket.packages.*.name, [""]), 0)
}

output "resources_bucket" {
  value = element(concat(google_storage_bucket.resources.*.name, [""]), 0)
}

output "backup_bucket" {
  value = element(concat(google_storage_bucket.backup.*.name, [""]), 0)
}

output "ws_router_pool" {
  value = module.websocket.name
}

output "ssh_lb_name" {
  value = module.ssh-lb.name
}

output "ssh_router_pool" {
  value = module.ssh-lb.name
}

output "tcp_lb_name" {
  value = module.tcprouter.name
}

output "tcp_router_pool" {
  value = module.tcprouter.name
}

output "pas_subnet_gateway" {
  value = google_compute_subnetwork.pas.gateway_address
}

output "pas_subnet_ip_cidr_range" {
  value = google_compute_subnetwork.pas.ip_cidr_range
}

output "pas_subnet_name" {
  value = google_compute_subnetwork.pas.name
}

output "services_subnet_gateway" {
  value = google_compute_subnetwork.services.gateway_address
}

output "services_subnet_ip_cidr_range" {
  value = google_compute_subnetwork.services.ip_cidr_range
}

output "services_subnet_name" {
  value = google_compute_subnetwork.services.name
}

output "lb_name" {
  value = var.global_lb > 0 ? module.gorouter.backend_service_name : module.gorouter.name
}

output "cf_ws_address" {
  value = module.websocket.address
}

output "haproxy_static_ip" {
  value = local.haproxy_static_ip
}

output "sql_username" {
  value = element(concat(random_id.pas_db_username.*.b64, [""]), 0)
}

output "sql_password" {
  sensitive = true
  value     = element(concat(random_id.pas_db_password.*.b64, [""]), 0)
}

