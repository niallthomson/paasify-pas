resource "tls_private_key" "dummy" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

data "template_file" "mysql_configuration" {
  template = chomp(file("${path.module}/templates/mysql-config.yml"))

  vars = {
    az_configuration = var.az_configuration
    az               = var.singleton_az
    plan_azs         = join(", ", var.availability_zones)
    backup_key       = jsonencode(tls_private_key.dummy.private_key_pem)
    run_smoke_tests  = local.run_smoke_tests
  }
}

module "mysql" {
  source = "github.com/niallthomson/paasify-core//opsmanager-tile"

  slug         = "pivotal-mysql"
  tile_version = local.tile_versions["mysql"]
  iaas         = var.iaas
  config       = data.template_file.mysql_configuration.rendered

  provisioner_host        = var.provisioner_host
  provisioner_username    = var.provisioner_ssh_username
  provisioner_private_key = var.provisioner_ssh_private_key

  skip = contains(var.tiles, "mysql") ? false : true

  blocker = module.pas.blocker
}