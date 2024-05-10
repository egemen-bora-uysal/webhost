resource "google_compute_security_policy" "cloud_armor_policy" {
  name        = "${var.name}-allow-single-ip-policy"
  description = "Cloud Armor security policy for ${var.name}-lb"
  type        = "CLOUD_ARMOR"

  rule {
    priority    = 1000
    description = "Allow traffic from specified IP addresses"
    action      = "allow"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = var.cloud_armor_allowed_ips
      }
    }
  }

  rule {
    priority    = 2147483647
    description = "Default rule to deny all traffic"
    action      = "deny(403)"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
  }
}
