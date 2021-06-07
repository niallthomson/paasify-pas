data "template_file" "redis_configuration" {
  template = chomp(file("${path.module}/templates/redis-config.yml"))

  vars = {
    az_configuration = var.az_configuration
    az               = var.singleton_az
    plan_azs         = join(", ", var.availability_zones)
    run_smoke_tests  = local.run_smoke_tests
  }
}

module "redis" {
  source = "github.com/niallthomson/paasify-core//opsmanager-tile"

  slug         = "p-redis"
  tile_version = local.tile_versions["redis"]
  iaas         = var.iaas
  config       = data.template_file.redis_configuration.rendered

  provisioner_host        = var.provisioner_host
  provisioner_username    = var.provisioner_ssh_username
  provisioner_private_key = var.provisioner_ssh_private_key

  skip = contains(var.tiles, "redis") ? false : true

  blocker = module.pas.blocker
}