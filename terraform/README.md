# terraform for forseti-demo
Terraform IaC for forseti-demo

## What it creates
This creates a randomly named project with the format `label-project-AAAA` where AAAA is a random string 4 characters long.
In this project it will create two resources:
* A e2-micro Google Cloud Compute Instance, the name will be `test-instance-AAAA` where AAAA is a random string 4 characters long.
* A Google Cloud Storage Bucket, the name will be `test-bucket-AAAA` where AAAA is a random string 4 characters long.

## Requirements

* a Forseti project has been manually created through the console.

## How to use

Go to the root of this repository (so you can see the terraform folder)

Git clone the helper dependency from the official Forseti Security project
```
git clone --branch modulerelease522 --depth 1 https://github.com/forseti-security/terraform-google-forseti.git
```
Go to the terraform folder
Copy the terraform.tfvars-example to terraform.tfvars
```
cp terraform.tfvars-example terraform.tfvars
```

Modify terraform.tfvars with your favorite editor and set the variables correctly (obtain these through the Google Cloud Console)

After that execute the following from inside the terraform folder (which you should still be in)

```
sh ../terraform-google-forseti/helpers/setup.sh -p YOUR_PROJECT_ID -o YOUR_ORG_ID
```

After the Cloud Foundation user account has been created by the helper, please make sure it gets these IAM rights from Organization Level.

Do this by going to the Console, switch to your organization and go to IAM - You can also modify and use this link: https://console.cloud.google.com/iam-admin/iam?organizationId=YOUR_ORG_ID&supportedpurview=project

```
* Billing Account Administrator
* Security Reviewer
* Service Account Admin
* Organisation Administrator
* Project Creator
```

After that is done you can use these commands to create the forseti and test label project:

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
Note: you should still have this code available locally from the earlier step when creating the helper.
