
resource "google_compute_backend_service" "lb_backend" {
  name        = "${var.name}-lb-backend"
  description = "Backend service for ${var.name}-lb"
  project     = var.project_id
  backend {
    group = google_compute_instance_group_manager.mig_manager.instance_group
  }
  protocol    = "HTTP"
  timeout_sec = 30
  health_checks = [
    google_compute_http_health_check.lb_health_check.id
  ]
  security_policy = google_compute_security_policy.cloud_armor_policy.id
}

resource "google_compute_url_map" "lb_url_map" {
  name            = "${var.name}-lb"
  description     = "URL map for ${var.name}-lb"
  project         = var.project_id
  default_service = google_compute_backend_service.lb_backend.id
}

resource "google_compute_target_http_proxy" "lb_http_proxy" {
  name        = "${var.name}-lb-http-proxy"
  description = "HTTP proxy for ${var.name}-lb"
  project     = var.project_id
  url_map     = google_compute_url_map.lb_url_map.id
}

resource "google_compute_global_address" "lb_external_ip" {
  name        = "${var.name}-lb-external-ip"
  description = "External static IP for ${var.name}-lb"
}

resource "google_compute_global_forwarding_rule" "lb_forwarding_rule" {
  name        = "${var.name}-lb-forwarding-rule"
  description = "Forwarding rule for ${var.name}-lb"
  project     = var.project_id
  target      = google_compute_target_http_proxy.lb_http_proxy.id
  port_range  = "80"
  ip_address  = google_compute_global_address.lb_external_ip.self_link
}

resource "google_compute_http_health_check" "lb_health_check" {
  name                = "${var.name}-lb-health-check"
  description         = "HTTP health check for ${var.name}-lb"
  project             = var.project_id
  port                = 80
  check_interval_sec  = 5
  timeout_sec         = 5
  unhealthy_threshold = 2
  healthy_threshold   = 2
}
