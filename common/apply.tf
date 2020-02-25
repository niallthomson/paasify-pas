locals {
  tile_versions = var.tile_versions[var.pas_version]
  apply_blocker = sha256("${module.pas.blocker}${module.mysql.blocker}${module.credhub.blocker}")
}

module "apply_changes" {
  source = "github.com/niallthomson/paasify-core//apply-changes"

  provisioner_host            = var.provisioner_host
  provisioner_ssh_username    = var.provisioner_ssh_username
  provisioner_ssh_private_key = var.provisioner_ssh_private_key

  blocker       = local.apply_blocker
}