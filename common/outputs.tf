output "ops_manager_version" {
  value = local.ops_manager_version.version
}

output "ops_manager_build" {
  value = local.ops_manager_version.build
}

output "api_endpoint" {
  value = "https://api.${var.sys_domain}"
}

output "apps_manager_endpoint" {
  value = "https://apps.${var.sys_domain}"
}