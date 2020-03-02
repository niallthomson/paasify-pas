locals {
  app_domain = "apps.${module.pave.base_domain}"
  sys_domain = "sys.${module.pave.base_domain}"
}

resource "google_dns_record_set" "wildcard-sys-dns" {
  name = "*.${local.sys_domain}."
  type = "A"
  ttl  = 300

  managed_zone = module.pave.dns_zone_name

  rrdatas = [ google_compute_global_address.http-lb.address ]
}

resource "google_dns_record_set" "doppler-sys-dns" {
  name = "doppler.${local.sys_domain}."
  type = "A"
  ttl  = 300

  managed_zone = module.pave.dns_zone_name

  rrdatas = [ google_compute_address.websocket-lb.address ]
}

resource "google_dns_record_set" "loggregator-sys-dns" {
  name = "loggregator.${local.sys_domain}."
  type = "A"
  ttl  = 300

  managed_zone = module.pave.dns_zone_name

  rrdatas = [ google_compute_address.websocket-lb.address ]
}

resource "google_dns_record_set" "wildcard-apps-dns" {
  name = "*.${local.app_domain}."
  type = "A"
  ttl  = 300

  managed_zone = module.pave.dns_zone_name

  rrdatas = [ google_compute_global_address.http-lb.address ]
}

resource "google_dns_record_set" "wildcard-ws-dns" {
  name = "*.ws.${module.pave.base_domain}."
  type = "A"
  ttl  = 300

  managed_zone = module.pave.dns_zone_name

  rrdatas = [ google_compute_address.websocket-lb.address ]
}

resource "google_dns_record_set" "app-ssh-dns" {
  name = "ssh.${local.sys_domain}."
  type = "A"
  ttl  = 300

  managed_zone = module.pave.dns_zone_name

  rrdatas = [ google_compute_address.ssh-lb.address ]
}

resource "google_dns_record_set" "tcp-dns" {
  name = "tcp.${local.sys_domain}."
  type = "A"
  ttl  = 300

  managed_zone = module.pave.dns_zone_name

  rrdatas = [ google_compute_address.tcp-lb.address ]
}