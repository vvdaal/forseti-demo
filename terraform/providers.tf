provider "google" {
  credentials = file("terraform-sa.json")
}

provider "google-beta" {
  credentials = file("account.json")
  project     = "my-project-id"
  region      = "us-central1"
}
