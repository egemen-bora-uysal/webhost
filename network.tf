resource "google_compute_network" "vpc_network" {
  project                                   = var.project_id
  name                                      = "${var.name}-vpc"
  description                               = "VPC Network for ${var.name} host machines"
  auto_create_subnetworks                   = false
  mtu                                       = 1460
  network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
  routing_mode                              = "REGIONAL"

}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name          = "${var.name}-subnetwork"
  ip_cidr_range = var.ip_range
  region        = var.region
  network       = google_compute_network.vpc_network.id
  secondary_ip_range {
    range_name    = "${var.name}-pods-ip-range"
    ip_cidr_range = var.subnet_pod_ip_range
  }
  secondary_ip_range {
    range_name    = "${var.name}-svc-ip-range"
    ip_cidr_range = var.subnet_svc_ip_range
  }
}

