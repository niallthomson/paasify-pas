locals {
  tls_full_chain = "${var.tls_cert}${var.tls_ca_cert}"
}

data "template_file" "pas_configuration" {
  template = "${chomp(file("${path.module}/templates/pas-config.yml"))}"

  vars = {
    az_configuration = var.az_configuration
    az               = var.singleton_az

    tls_cert         = "${jsonencode(local.tls_full_chain)}"
    tls_private_key  = "${jsonencode(var.tls_private_key)}"
    tls_ca_cert      = "${jsonencode(var.tls_ca_cert)}"

    ssh_elb_names         = "${join(", ", var.ssh_elb_names)}"
    web_elb_names        = "${join(", ", var.web_elb_names)}"
    compute_instances    = "${var.compute_instances}"
    apps_domain          = "${var.apps_domain}"
    sys_domain           = "${var.sys_domain}"
  }
}

module "pas" {
  source = "github.com/niallthomson/paasify-core//opsmanager-tile"

  slug         = "elastic-runtime"
  tile_version = "2.8.1"
  om_product   = "cf"
  glob         = "srt"
  iaas         = var.iaas
  config       = data.template_file.pas_configuration.rendered
  ops_file     = var.pas_ops_file

  provisioner_host        = var.provisioner_host
  provisioner_username    = var.provisioner_ssh_username
  provisioner_private_key = var.provisioner_ssh_private_key

  blocker                 = var.blocker
}