resource "google_service_account" "compute_service_account" {
  account_id   = "test_compute_service_account"
  display_name = "Test Compute Service Account"
  description = "A test compute service account
  project = "label-project-${random_string.project_append.result}"
}
