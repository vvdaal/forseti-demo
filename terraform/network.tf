# Generate a random network resource append string
resource "random_string" "network_resource_append" {
  length  = 4
  upper   = false
  number  = true
  lower   = true
  special = false
}

resource "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
  project       = google_project.label_project.project_id 
  name          = "test-subnetwork-${random_string.network_resource_append.result}"
  ip_cidr_range = "10.1.0.0/16"
  region        = "europe-west4"
  network       = google_compute_network.test_network.id
  log_config {
    flow_sampling        = 1
  }
  depends_on = [google_project.label_project]
}

resource "google_compute_network" "test_network" {
  project       = google_project.label_project.project_id
  name          = "test-network-${random_string.network_resource_append.result}"
  auto_create_subnetworks = false
}
