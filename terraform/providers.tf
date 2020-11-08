provider "google" {
  credentials = file("credentials.json")
}

provider "google-beta" {
  credentials = file("credentials.json")
}
