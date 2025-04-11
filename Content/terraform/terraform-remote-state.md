# Terraform State Backends

The following README will provide an explanation on terraform backends, and some examples of remote backends. 

## What Are Terraform Backends?

A Terraform "backend" is the method Terraform uses to store a module's state.

Terraform's default behaviour is to use the `local` backend, which saves state information to a local `terraform.tfstate` file. 


## Remote State Backends
A remote state backend, as the name implies, is a Terraform backend that stores the module's state somewhere else. 
There are several reasons why you might want to do this, among them:
- **State Locking:** Remote backends can provide support for locking the module's state so it can only be updated by one person or process at a time, preventing conflicts.
- **Security:** A remote backend provider can offer enhanced security controls to manage access to the state, and other security features like at-rest encryption.
- **Versioning/Rollbacks:** Some remote backends support versioning so you can keep a detailed history of changes made to the state, and restore a previous version if necessary.


## Bootstrapping
Terraform can't dynamically create a remote backend as part of a module, the backend needs to be provisioned separately first and then configured in the `terraform` block.

The remote backends listed below will contain both examples for creating the backend, and configuring Terraform to use it.

## Examples

### S3 Backend (s3)
Helpful docs:
- https://developer.hashicorp.com/terraform/language/backend/s3
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

The `s3` backend allows you to store Terraform state in an AWS S3 Bucket.

You need to create the bucket first before using it in a Terraform module.

After the bucket has been created, you can store the state for multiple modules under separate keys in the same bucket.

As of today, Terraform still supports using a DynamoDB table as the locking mechanism for this backend, however, they've marked this feature as "Deprecated" in their official documentation and recommned using `use_lockfile` instead. This implements locking by adding a lockfile inside the bucket with a name of `"<state-file-key-name>.tflock"` 
(You can easily see where this is implemented in their sources, which is pretty cool: [Last two methods in the file on this commit](https://github.com/terraform-google-modules/terraform-docs-samples/blob/main/storage/remote_terraform_backend_template/main.tf)  )

bucket configuration example:
```
resource "aws_s3_bucket" "terraform_state" {
  bucket = "my-terraform-state-bucket"
}

resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Restrict public unauthenticated access to the bucket
resource "aws_s3_bucket_public_access_block" "tfstate_bucket" {
  bucket                  = aws_s3_bucket.tfstate_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
```

configuration for using the created bucket as a backend:
```
terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket" # name of the existing bucket
    key    = "path/to/example-1-state"   # key to store the state under 
    region = "us-east-1"                 # region the bucket is in
    use_lockfile = true                  # enable locking
  }
}
```

A working example you can provision can be found at [resources/terraform/examples/s3-backend/bootstrap](/resources/terraform/examples/s3-backend/bootstrap) in this repo

---
