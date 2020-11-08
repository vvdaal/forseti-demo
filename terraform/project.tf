# Local service api list
locals {
  gcp_service_list = [
    "iam.googleapis.com",
    "cloudkms.googleapis.com",
    "storage.googleapis.com",
    "compute.googleapis.com",
    "sqladmin.googleapis.com",
    "logging.googleapis.com",
    "cloudasset.googleapis.com",
    "cloudresourcemanager.googleapis.com",
  ]
}

# Generate a random project append string
resource "random_string" "project_append" {
  length  = 4
  upper   = false
  number  = true
  lower   = true
  special = false
}

# Generate the project
resource "google_project" "label_project" {
  name            = "Testing labels on resources"
  project_id      = "label-project-${random_string.project_append.result}"
  org_id          = var.org_id
  billing_account = var.billing_account
  auto_create_network = false
}

# Enable services in newly created GCP Project.
resource "google_project_service" "gcp_services_label_project" {
  count   = length(local.gcp_service_list)
  project = google_project.label_project.project_id
  service = local.gcp_service_list[count.index]

  disable_dependent_services = true
}

# Enable services in Forseti Project.
resource "google_project_service" "gcp_services_forseti_project" {
  count   = length(local.gcp_service_list)
  project = var.forseti_project_name
  service = local.gcp_service_list[count.index]

  disable_dependent_services = true
}


