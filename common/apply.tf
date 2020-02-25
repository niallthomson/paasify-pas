locals {
  tile_versions  = var.tile_versions[var.pas_version]
  apply_blockers = [
    module.pas.blocker,
    module.mysql.blocker,
    module.rabbitmq.blocker,
    module.redis.blocker,
    module.scs.blocker,
    module.gateway.blocker,
    module.sso.blocker,
    module.credhub.blocker,
  ]
  apply_blocker  = sha256(join("", local.apply_blockers))
}

module "apply_changes" {
  source = "github.com/niallthomson/paasify-core//apply-changes"

  provisioner_host            = var.provisioner_host
  provisioner_ssh_username    = var.provisioner_ssh_username
  provisioner_ssh_private_key = var.provisioner_ssh_private_key

  blocker       = local.apply_blocker
}