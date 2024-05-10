resource "google_storage_bucket" "bucket" {
  name                        = "${var.name}-bucket"
  storage_class               = "REGIONAL"
  project                     = var.project_id
  location                    = var.region
  force_destroy               = true
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
}

resource "google_storage_bucket_object" "html_object" {
  name   = "index.nginx-debian-custom.html"
  source = "${path.module}/html-files/index.nginx-debian-custom.html"
  bucket = google_storage_bucket.bucket.name
}
