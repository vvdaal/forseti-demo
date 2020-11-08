module "forseti" {
  source  = "terraform-google-modules/forseti/google"
  version = "~> 5.2.2"

  gsuite_admin_email                        = var.gsuite_admin_email
  domain                                    = var.domain
  project_id                                = var.forseti_project_name
  org_id                                    = var.org_id
  cscc_violations_enabled                   = true
  #cscc_source_id                            = var.cscc_source_id
  config_validator_enabled                  = true
  config_validator_violations_should_notify = true
  storage_bucket_location                   = "europe-west4"
  bucket_cai_location                       = "europe-west4"
  # The range belows allows IAP SSH tunneling
  server_ssh_allow_ranges = ["35.235.240.0/20"]
  client_ssh_allow_ranges = ["35.235.240.0/20"]
  server_region           = "europe-west4"
  server_type             = "e2-standard-2"
  client_region           = "europe-west4"
  client_type             = "e2-standard-2"
  cloudsql_type           = "db-n1-standard-1"
  cloudsql_region         = "europe-west4"
}
