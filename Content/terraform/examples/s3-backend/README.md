# Terraform S3 Backend Example 

You can find an in depth explanation of Terraform backends here -  [Content/Terraform/terraform-remote-state.md](/Content/Terraform/terraform-remote-state.md)

## Prerequisites

To follow allong with this example, you'll need to:
- configure your local environment to allow Terraform to use the AWS Provider
- install and authenticate the AWS CLI

## Instructions

### Bucket Provisioning
1. enter the bootstrap dir `cd bootstrap`
2. initialize and apply terraform `terraform init; terraform apply -auto-approve`
3. get the name of the created bucket with `terraform output bucket`
3. you can verify that the bucket exists with the aws cli `aws s3api head-bucket --bucket <your-bucket-name>`

### Testing The Backend
1. now you can go back up to the root of this example `cd ..`
2. modify `main.tf` so the backend block contains the created bucket's name and the correct region
2. initialize and apply terraform `terraform init; terraform apply -auto-approve`
3. You can use the aws cli to list the contents of the bucket and see the state file in it! `aws s3 ls s3://<your-bucket-name> --recursive`


### Common Issues

- S3 bucket creation fails with a `409 BucketAlreadyExists` error
   - AWS requires every single s3 bucket in a region to have a totally unique name, even across different accounts! 
   - try changing the `unique_bucket_prefix` variable to something even more unique :)  

- AWS Provider Initialization fails with `403 InvalidClientTokenId`
  -  this might be because of a mismatch between the AWS region you have configured locally with the AWS CLI and the region specified in the terraform module, 
  - get your configured aws region with `aws configure get region`
  - try creating the bucket with that region by changing the region var `terraform apply -var 'region=<region name>'`




