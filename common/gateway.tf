data "template_file" "gateway_configuration" {
  template = chomp(file("${path.module}/templates/gateway-config.yml"))

  vars = {
    az_configuration = var.az_configuration
    az               = var.singleton_az
  }
}

module "gateway" {
  source = "github.com/niallthomson/paasify-core//opsmanager-tile"

  slug         = "spring-cloud-gateway"
  tile_version = local.tile_versions["gateway"]
  om_product   = "p_spring-cloud-gateway-service"
  iaas         = var.iaas
  config       = data.template_file.gateway_configuration.rendered

  provisioner_host        = var.provisioner_host
  provisioner_username    = var.provisioner_ssh_username
  provisioner_private_key = var.provisioner_ssh_private_key

  skip = contains(var.tiles, "gateway") ? false : true

  blocker = module.pas.blocker
}