resource "google_service_account" "compute_service_account" {
  account_id   = "test-compute-sa"
  display_name = "Test Compute Service Account"
  description = "A test compute service account"
  project = google_project.label_project.project_id
}
