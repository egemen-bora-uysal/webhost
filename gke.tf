module "kubernetes-engine_private-cluster" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version = "~> 26.1"

  name               = "${var.name}-gke"
  project_id         = var.project_id
  network_project_id = var.project_id
  regional           = false
  zones              = [var.zone]

  network                 = google_compute_network.vpc_network.name
  subnetwork              = google_compute_subnetwork.vpc_subnetwork.name
  ip_range_pods           = "${var.name}-pods-ip-range"
  ip_range_services       = "${var.name}-svc-ip-range"
  master_ipv4_cidr_block  = var.master_ip_range
  create_service_account  = false
  service_account         = google_service_account.gke-service-account.email
  grant_registry_access   = true
  release_channel         = "STABLE"
  enable_private_nodes    = true
  enable_private_endpoint = false


  remove_default_node_pool  = true
  default_max_pods_per_node = "32"

  node_pools = [
    {
      name           = "${var.name}-node-pool"
      image_type     = "cos_containerd"
      node_locations = var.zone
      disk_size_gb   = 20
      machine_type   = "e2-medium"
      auto_upgrade   = true
      auto_repair    = true

      # [AUTOSCALING ENABLED]
      # initial_node_count = 1
      # min_count          = 1
      # max_count          = 3

      # [AUTOSCALING DISABLED]
      node_count  = 2
      autoscaling = false



    },
  ]

  node_pools_tags = {
    "${var.name}-gke-pool" : [
      "$foo-node-pool"
    ]
  }

  node_pools_metadata = {
    all = {
      disable_legacy_metadata_endpoints = true
    }
  }

}