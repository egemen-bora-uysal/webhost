resource "google_compute_firewall" "allow_http" {
  name    = "${google_compute_network.vpc_network.name}-allow-http"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = [
    "0.0.0.0/0"
  ]

}

resource "google_compute_firewall" "allow_iap" {
  name        = "${google_compute_network.vpc_network.name}-allow-iap"
  description = "Allow traffic through Google's IAP IPs"
  network     = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22", "3389"]
  }

  source_ranges = [
    "35.235.240.0/20"
  ]

}

resource "google_compute_firewall" "allow_healthcheck" {
  name        = "${google_compute_network.vpc_network.name}-allow-healthcheck"
  description = "Allow traffic from Google Health Check IPs"
  network     = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = [
    "35.191.0.0/16",
    "130.211.0.0/22"
  ]
}
