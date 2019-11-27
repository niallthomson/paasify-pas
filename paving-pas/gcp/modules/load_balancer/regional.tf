resource "google_compute_address" "lb" {
  name = "${var.env_name}-${var.name}-address"

  count = var.lb_count
}

resource "google_compute_forwarding_rule" "lb" {
  name        = "${var.env_name}-${var.name}-lb-${count.index}"
  ip_address  = google_compute_address.lb[0].address
  target      = google_compute_target_pool.lb[0].self_link
  port_range  = element(var.forwarding_rule_ports, count.index)
  ip_protocol = "TCP"

  count = var.lb_count > 0 ? length(var.forwarding_rule_ports) : 0
}

resource "google_compute_target_pool" "lb" {
  name = var.lb_name

  health_checks = google_compute_http_health_check.lb.*.name

  count = var.lb_count
}

