resource "google_compute_router_nat" "cloud_nat" {
  name                                = "${var.name}-nat"
  router                              = google_compute_router.cloud_router.name
  region                              = google_compute_router.cloud_router.region
  nat_ip_allocate_option              = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat  = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  min_ports_per_vm                    = 64
  enable_endpoint_independent_mapping = false
}
