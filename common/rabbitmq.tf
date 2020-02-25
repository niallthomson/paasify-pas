data "template_file" "rabbitmq_configuration" {
  template = "${chomp(file("${path.module}/templates/rabbitmq-config.yml"))}"

  vars = {
    az_configuration = var.az_configuration
    az               = var.singleton_az
    plan_azs         = join(", ", var.availability_zones)
  }
}

module "rabbitmq" {
  source = "github.com/niallthomson/paasify-core//opsmanager-tile"

  slug         = "p-rabbitmq"
  tile_version = local.tile_versions["rabbitmq"]
  iaas         = var.iaas
  config       = data.template_file.rabbitmq_configuration.rendered

  provisioner_host        = var.provisioner_host
  provisioner_username    = var.provisioner_ssh_username
  provisioner_private_key = var.provisioner_ssh_private_key

  skip                    = contains(var.tiles, "rabbitmq") ? false : true

  blocker                 = module.pas.blocker
}