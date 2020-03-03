output "ops_manager_domain" {
  description = "Domain for accessing OpsManager"
  value       = module.pave.ops_manager_domain
}

output "ops_manager_username" {
  description = "Username for accessing OpsManager"
  value       = module.pave.ops_manager_username
}

output "ops_manager_password" {
  description = "Password for accessing OpsManager"
  value       = module.pave.ops_manager_password
}

output "cf_api_endpoint" {
  description = "Cloud Foundry API endpoint"
  value       = module.common.api_endpoint
}

output "cf_apps_manager_endpoint" {
  description = "Cloud Foundry Apps Manager endpoint"
  value       = module.common.apps_manager_endpoint
}

output "provisioner_host" {
  description = "Hostname for accessing provisioner instance"
  value       = module.pave.provisioner_host
}

output "provisioner_ssh_username" {
  description = "SSH username for accessing provisioner instance"
  value       = module.pave.provisioner_ssh_username
}

output "provisioner_ssh_private_key" {
  description = "SSH password for accessing provisioner instance"
  value       = module.pave.provisioner_ssh_private_key
}