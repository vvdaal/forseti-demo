# Generate a random compute instance append string
resource "random_string" "compute_append" {
  length  = 4
  upper   = false
  number  = true
  lower   = true
  special = false
}

resource "google_compute_instance" "test_instance_1" {
  name                      = "test-instance-${random_string.compute_append.result}"
  project                   = "label-project-${random_string.project_append.result}"
  machine_type              = "e2-micro"
  zone                      = "europe-west4-a"
  allow_stopping_for_update = true

  labels = {
    "owner"   = "vincent",
    "awesome" = "true"
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}
