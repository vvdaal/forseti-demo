# Generate a random kms resource append string
resource "random_string" "kms_resource_append" {
  length  = 20
  upper   = false
  number  = true
  lower   = true
  special = false
}

resource "google_kms_key_ring" "keyring" {
  name     = "keyring-test-${random-string.kms_resource_append.result}"
  location = "global"
}

resource "google_kms_crypto_key" "test-key" {
  name            = "crypto-key-test-${random-string.kms_resource_append.result}"
  key_ring        = google_kms_key_ring.keyring.id
  rotation_period = "2592000s"

  lifecycle {
    prevent_destroy = false
  }
  
  protection_level = "HSM"
}
