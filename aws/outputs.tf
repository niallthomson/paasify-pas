output "ops_manager_domain" {
  value = module.pave.ops_manager_domain
}

output "ops_manager_username" {
  value = module.pave.ops_manager_username
}

output "ops_manager_password" {
  value = module.pave.ops_manager_password
}

output "api_endpoint" {
  value = module.common.api_endpoint
}

output "apps_manager_endpoint" {
  value = module.common.apps_manager_endpoint
}

output "provisioner_host" {
  value = module.pave.provisioner_host
}

output "provisioner_ssh_username" {
  value = module.pave.provisioner_ssh_username
}

output "provisioner_ssh_private_key" {
  value = module.pave.provisioner_ssh_private_key
}