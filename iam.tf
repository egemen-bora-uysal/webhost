resource "google_service_account" "gke-service-account" {
  account_id   = "gke-sa"
  display_name = "GKE Service Account"
}

resource "google_project_iam_member" "gke-role-binding" {
  project = var.project_id

  for_each = toset([
    "roles/artifactregistry.reader",
    "roles/storage.objectViewer",
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/stackdriver.resourceMetadata.writer",
  ])
  role = each.key


  member = "serviceAccount:${google_service_account.gke-service-account.email}"
}
