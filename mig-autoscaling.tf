resource "google_compute_instance_group_manager" "mig_manager" {
  name               = "${var.name}-mig"
  base_instance_name = var.name
  zone               = var.zone
  version {
    instance_template = google_compute_instance_template.host_template.id
  }
  named_port {
    name = "http"
    port = 80
  }
  auto_healing_policies {
    health_check      = google_compute_health_check.autohealing.id
    initial_delay_sec = 300
  }
}

resource "google_compute_autoscaler" "mig-autoscaler" {
  name   = "${var.name}-autoscaler"
  zone   = var.zone
  target = google_compute_instance_group_manager.mig_manager.id

  autoscaling_policy {
    min_replicas    = var.min-replica-count
    max_replicas    = var.max-replica-count
    cooldown_period = 30

    cpu_utilization {
      target = var.cpu-target
    }
  }
}
