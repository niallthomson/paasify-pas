resource "google_compute_firewall" "tcp-lb-health-check" {
  name    = "${var.env_name}-tcp-lb-health-check"
  network = module.pave.network_name

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]

  target_tags = ["${var.env_name}-tcp-lb"]
}

resource "google_compute_firewall" "tcp-lb" {
  name    = "${var.env_name}-tcp-lb-firewall"
  network = module.pave.network_name

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["1024-65535"]
  }

  target_tags = ["${var.env_name}-tcp-lb"]
}

resource "google_compute_firewall" "websocket-lb-health-check" {
  name    = "${var.env_name}-websocket-lb-health-check"
  network = module.pave.network_name

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]

  target_tags = [google_compute_http_health_check.websocket-lb.name]
}

resource "google_compute_firewall" "websocket-lb" {
  name    = "${var.env_name}-websocket-lb-firewall"
  network = module.pave.network_name

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  target_tags = ["${var.env_name}-websocket-lb"]
}

resource "google_compute_firewall" "http-lb" {
  name    = "${var.env_name}-http-lb-firewall"
  network = module.pave.network_name

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  target_tags = ["${var.env_name}-http-lb"]
}