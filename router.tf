resource "google_compute_router" "cloud_router" {
  name    = "${var.name}-router"
  network = google_compute_network.vpc_network.name
  region  = var.region
}
