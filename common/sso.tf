data "template_file" "sso_configuration" {
  template = chomp(file("${path.module}/templates/sso-config.yml"))

  vars = {
    az_configuration = var.az_configuration
    az               = var.singleton_az
  }
}

module "sso" {
  source = "github.com/niallthomson/paasify-core//opsmanager-tile"

  slug         = "pivotal_single_sign-on_service"
  tile_version = local.tile_versions["sso"]
  om_product   = "Pivotal_Single_Sign-On_Service"
  iaas         = var.iaas
  config       = data.template_file.sso_configuration.rendered

  provisioner_host        = var.provisioner_host
  provisioner_username    = var.provisioner_ssh_username
  provisioner_private_key = var.provisioner_ssh_private_key

  skip = contains(var.tiles, "sso") ? false : true

  blocker = module.pas.blocker
}