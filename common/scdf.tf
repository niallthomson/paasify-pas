data "template_file" "scdf_configuration" {
  template = chomp(file("${path.module}/templates/scdf-config.yml"))

  vars = {
    az_configuration = var.az_configuration
    az               = var.singleton_az
  }
}

module "scdf" {
  source = "github.com/niallthomson/paasify-core//opsmanager-tile"

  slug         = "p-dataflow"
  tile_version = local.tile_versions["scdf"]
  iaas         = var.iaas
  config       = data.template_file.scdf_configuration.rendered

  provisioner_host        = var.provisioner_host
  provisioner_username    = var.provisioner_ssh_username
  provisioner_private_key = var.provisioner_ssh_private_key

  skip = contains(var.tiles, "scdf") ? false : true

  blocker = module.pas.blocker
}