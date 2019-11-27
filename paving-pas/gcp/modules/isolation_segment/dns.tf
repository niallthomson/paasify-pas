locals {
  haproxy_static_ip = cidrhost(var.pas_subnet_cidr, -19)
}

resource "google_dns_record_set" "wildcard-iso-dns" {
  name  = "*.iso.${var.dns_zone_dns_name}."
  type  = "A"
  ttl   = 300
  count = var.use_isolation_segment ? 1 : 0

  managed_zone = var.dns_zone_name

  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibility in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  rrdatas = [var.internetless ? local.haproxy_static_ip : google_compute_global_address.isoseg[0].address]
}

