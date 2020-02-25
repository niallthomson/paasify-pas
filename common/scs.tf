data "template_file" "scs_configuration" {
  template = "${chomp(file("${path.module}/templates/scs-config.yml"))}"

  vars = {
    az_configuration = var.az_configuration
    az               = var.singleton_az
  }
}

module "scs" {
  source = "github.com/niallthomson/paasify-core//opsmanager-tile"

  slug         = "p-spring-cloud-services"
  tile_version = local.tile_versions["scs"]
  om_product   = "p_spring-cloud-services"
  iaas         = var.iaas
  config       = data.template_file.scs_configuration.rendered

  provisioner_host        = var.provisioner_host
  provisioner_username    = var.provisioner_ssh_username
  provisioner_private_key = var.provisioner_ssh_private_key

  skip                    = contains(var.tiles, "scs") ? false : true

  blocker                 = module.pas.blocker
}