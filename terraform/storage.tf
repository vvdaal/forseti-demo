# Generate a random storage instance append string
resource "random_string" "storage_append" {
  length  = 20
  upper   = false
  number  = true
  lower   = true
  special = false
}

resource "google_storage_bucket" "test_bucket" {
  name          = "test-bucket-${random_string.storage_append.result}"
  project       = google_project.label_project.project_id
  location      = "EU"
  force_destroy = true

  uniform_bucket_level_access = true

  labels = {
    "awesome" = "true",
    "owner"   = "vincent"
  }
  
  encryption {
    default_kms_key_name = google_kms_crypto_key.test-key.id
  }
}
