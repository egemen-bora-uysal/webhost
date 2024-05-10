resource "google_compute_instance_template" "host_template" {
  name         = "${var.name}-template"
  machine_type = "e2-micro"

  network_interface {
    subnetwork = google_compute_subnetwork.vpc_subnetwork.name
    # ## Public Ephemeral IP
    # access_config {
    # }
    # ##
  }
  disk {
    source_image = "debian-cloud/debian-11"
    auto_delete  = true
    boot         = true
  }
  service_account {
    email  = "549316996083-compute@developer.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    systemctl start nginx
    systemctl enable nginx
    gsutil cp gs://${google_storage_bucket.bucket.name}/${google_storage_bucket_object.html_object.name} tmp/html/index.nginx-debian.html
    HOST_NAME=$(curl -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/name")
    export HOST_NAME="$${HOST_NAME##*/}"
    envsubst < tmp/html/index.nginx-debian.html > /var/www/html/index.nginx-debian.html
    curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
    bash add-google-cloud-ops-agent-repo.sh --also-install
  EOF
}

resource "google_compute_health_check" "autohealing" {
  name                = "${var.name}-autohealing-health-check"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10 # 50 seconds

  http_health_check {
    request_path = "/"
    port         = "80"
  }
}
