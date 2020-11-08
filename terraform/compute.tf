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
  project                   = google_project.label_project.project_id 
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
    kms_key_self_link = google_kms_crypto_key.test-key.id
  }

  network_interface {
    network = google_compute_subnetwork.network-with-private-secondary-ip-ranges.id

    access_config {
      // Ephemeral IP
    }
  }
  
  shielded_instance_config {
    enable_secure_boot = true
  }
  
  metadata = {
    block-project-ssh-keys = true
  }
  
  service_account {
    email = google_service_account.compute_service_account.email
    scopes = ["cloud-platform"]
  }
}
