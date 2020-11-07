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
