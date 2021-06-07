data "template_file" "metric_store_configuration" {
  template = chomp(file("${path.module}/templates/metric-store-config.yml"))

  vars = {
    az_configuration = var.az_configuration
    az               = var.singleton_az
  }
}

module "metric_store" {
  source = "github.com/niallthomson/paasify-core//opsmanager-tile"

  slug         = "p-metric-store"
  tile_version = local.tile_versions["metric_store"]
  om_product   = "metric-store"
  iaas         = var.iaas
  config       = data.template_file.metric_store_configuration.rendered
  ops_file     = lookup(var.tile_ops_files, "metric_store", "---")

  provisioner_host        = var.provisioner_host
  provisioner_username    = var.provisioner_ssh_username
  provisioner_private_key = var.provisioner_ssh_private_key

  skip = contains(var.tiles, "metrics") ? false : true

  blocker = module.pas.blocker
}

data "template_file" "metrics_configuration" {
  template = chomp(file("${path.module}/templates/metrics-config.yml"))

  vars = {
    az_configuration = var.az_configuration
    az               = var.singleton_az
    run_smoke_tests  = local.run_smoke_tests
  }
}

module "metrics" {
  source = "github.com/niallthomson/paasify-core//opsmanager-tile"

  slug         = "apm"
  tile_version = local.tile_versions["metrics"]
  om_product   = "appMetrics"
  iaas         = var.iaas
  config       = data.template_file.metrics_configuration.rendered
  ops_file     = lookup(var.tile_ops_files, "metrics", "---")

  provisioner_host        = var.provisioner_host
  provisioner_username    = var.provisioner_ssh_username
  provisioner_private_key = var.provisioner_ssh_private_key

  skip = contains(var.tiles, "metrics") ? false : true

  blocker = module.metric_store.blocker
}