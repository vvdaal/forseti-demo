# terraform for forseti-demo
Terraform IaC for forseti-demo

## What it creates
This creates a randomly named project with the format `label-project-AAAA` where AAAA is a random string 4 characters long.
In this project it will create two resources:
* A e2-micro Google Cloud Compute Instance, the name will be `test-instance-AAAA` where AAAA is a random string 4 characters long.
* A Google Cloud Storage Bucket, the name will be `test-bucket-AAAA` where AAAA is a random string 4 characters long.

## Requirements

* Terraform helper has been ran .
* a Forseti project has been created.
* Cloud Foundation account has these permissions (grant these manually in the console):
  * Permissions cloud foundation project:
  * Billing Account Administrator
  * Security Reviewer
  * Service Account Admin
  * Organisation Administrator
  * Project Creator

## How to use
```
terraform init
terraform apply
```

After Forseti has been deployed please read the following links

* https://forsetisecurity.org/docs/v2.23/configure/inventory/gsuite.html
* https://forsetisecurity.org/docs/v2.23/configure/notifier/index.html#cloud-scc-notification
    * After activating this integration, add the Source ID into the Terraform configuration by uncommenting the cscc_source_id input in terraform.tfvars and forseti.tf and re-run the Terraform apply command.
## How to cleanup
```
terraform destroy
```

To clean-up the helper service account please follow https://forsetisecurity.org/docs/v2.23/setup/install.html#cleanup
