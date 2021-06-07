# TODO: Enabled S3 encryption for filestore
data "template_file" "pas_ops_file" {
  template = chomp(file("${path.module}/templates/pas-config-ops.yml"))

  vars = {
    project               = var.project
    service_account_email = module.pave.ops_manager_service_account_email
    service_account_key   = jsonencode(module.pave.ops_manager_service_account_key)
    droplets_bucket       = google_storage_bucket.droplets.name
    packages_bucket       = google_storage_bucket.packages.name
    buildpacks_bucket     = google_storage_bucket.buildpacks.name
    resources_bucket      = google_storage_bucket.resources.name
    backup_bucket         = google_storage_bucket.backup.name
  }
}