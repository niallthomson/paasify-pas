// Modify dns records to resolve to the ha proxy when in internetless mode.
locals {
  haproxy_static_ip = cidrhost(google_compute_subnetwork.pas.ip_cidr_range, -20)
  cf_address        = var.global_lb > 0 ? module.gorouter.global_address : module.gorouter.address
  cf_ws_address     = var.global_lb > 0 ? module.websocket.address : module.gorouter.address
}

resource "google_dns_record_set" "wildcard-sys-dns" {
  name = "*.sys.${var.dns_zone_dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.dns_zone_name

  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibility in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  rrdatas = [var.internetless ? local.haproxy_static_ip : local.cf_address]
}

resource "google_dns_record_set" "doppler-sys-dns" {
  name = "doppler.sys.${var.dns_zone_dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.dns_zone_name

  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibility in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  rrdatas = [var.internetless ? local.haproxy_static_ip : local.cf_ws_address]
}

resource "google_dns_record_set" "loggregator-sys-dns" {
  name = "loggregator.sys.${var.dns_zone_dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.dns_zone_name

  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibility in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  rrdatas = [var.internetless ? local.haproxy_static_ip : local.cf_ws_address]
}

resource "google_dns_record_set" "wildcard-apps-dns" {
  name = "*.apps.${var.dns_zone_dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.dns_zone_name

  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibility in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  rrdatas = [var.internetless ? local.haproxy_static_ip : local.cf_address]
}

resource "google_dns_record_set" "wildcard-ws-dns" {
  name = "*.ws.${var.dns_zone_dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.dns_zone_name

  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibility in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  rrdatas = [var.internetless ? local.haproxy_static_ip : local.cf_ws_address]
}

resource "google_dns_record_set" "app-ssh-dns" {
  name = "ssh.sys.${var.dns_zone_dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.dns_zone_name

  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibility in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  rrdatas = [var.internetless ? local.haproxy_static_ip : module.ssh-lb.address]
}

resource "google_dns_record_set" "tcp-dns" {
  name = "tcp.${var.dns_zone_dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.dns_zone_name

  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibility in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  rrdatas = [var.internetless ? local.haproxy_static_ip : module.tcprouter.address]
}

