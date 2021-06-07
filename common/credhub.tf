data "template_file" "credhub_configuration" {
  template = chomp(file("${path.module}/templates/credhub-config.yml"))

  vars = {
    az_configuration = var.az_configuration
    az               = var.singleton_az
  }
}

module "credhub" {
  source = "github.com/niallthomson/paasify-core//opsmanager-tile"

  slug         = "credhub-service-broker"
  tile_version = local.tile_versions["credhub"]
  iaas         = var.iaas
  config       = data.template_file.credhub_configuration.rendered

  provisioner_host        = var.provisioner_host
  provisioner_username    = var.provisioner_ssh_username
  provisioner_private_key = var.provisioner_ssh_private_key

  skip = contains(var.tiles, "credhub") ? false : true

  blocker = module.pas.blocker
}