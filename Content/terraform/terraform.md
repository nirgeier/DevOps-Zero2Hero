# Terraform README

The following README will explain Terraform, its use cases, and commands.

## What is Terraform?

Terraform is an **Infrastructure as Code (IaC)** tool that allows you to manage your infrastructure using simple code. Terraform supports multiple cloud providers, such as AWS, GCP, Azure, VMware, and more.

### Advantages
- **Collaboration**: It allows teams to work together (locks the state when applying changes).
- **Multi-cloud Support**: Terraform supports a variety of cloud providers.
- **Official Documentation**: Terraform has clear and comprehensive documentation for most use cases and examples.
- **Create/Destroy Resources**: Easily create or destroy resources with a single command.
- **Cross-region Infrastructure**: You can create infrastructure in multiple regions (e.g., EC2 instances in different regions with their respective AMIs).

### Disadvantages
- **State File Management**: Terraform saves configuration in a state file. If the file becomes corrupted, it can lead to resource management issues.
- **Limited Resource Support**: Some newer features or resources may not be immediately supported by Terraform.
- **No Built-in Error Handling**: Terraform doesn’t automatically handle errors, requiring you to debug issues manually.
- **Complex Dependencies**: Although Terraform manages dependencies, complex inter-module or inter-environment dependencies can become hard to manage.

### Basic Terminology in Terraform

- **File Extensions**: Terraform configuration files use the `.tf` extension. While naming files is not mandatory, it is recommended to follow this naming convention:
  - `provider.tf` – For provider configuration.
  - `main.tf` – The primary configuration file that contains all infrastructure resources.
  - `variables.tf` – Defines all variables.
  - `outputs.tf` – Displays values or uses them for other configurations.

- **Modules**: A module is a container for multiple resources. You can use official modules provided by the providers or create your own. For example, using a module to create an S3 bucket in AWS:

```hcl
module "s3-bucket" {
  bucket = "test-bucket"
  source = "terraform-aws-modules/s3-bucket/aws"
  version = "4.6.0"
}
```
- Variables: Variables allow you to configure values in one place instead of hardcoding them in your code. You just need to reference the variable wherever required.
Example of varible usage:
```
variable "image_id" {
  type        = string
  description = "The ID of the machine image (AMI) to use for the server."
}

imageid = var.image_id

```
- Outputs: Outputs allow you to display values or pass them to other resources.
Example of output usage:
```
output "instance_public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP of the EC2 instance"
}

resource "aws_security_group" "example" {
  name        = "example-sg"
  description = "Allow SSH from EC2 instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${output.instance_public_ip}/32"]
  }
}
```
- Provider: The provider block contains the information necessary for Terraform to connect to your cloud provider (region, access key, secret key, etc.) and manage resources there. 
Example of provider configuration:
```
provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}
```
- Terraform block: you can use the `terraform` block to configure Terraform's behaviour. It is commonly used to define a required Terraform version, or an alternative backend ( [Read more about Terraform backends here](/Content/Terraform/terraform-remote-state.md) ).
```
terraform {
  required_verson = ">= major.minor.patch"
  backend "<type>" {
    ......
  }
}
```


- Resource: A resource is a component managed by Terraform. Resources can be created separately or as part of a module.
Example of resource usage:
```
resource "azurerm_resource_group" "jacks-rg" {
  name     = "jacks-rg"
  location = "UK South"
}
```
### Important Terraform Commands
Before applying any resources, you need to install the required plugins for the Terraform configuration files. This is done by running the following command (if you change the state file location, you will need to run terraform init again):
```
terraform init
```
Terraform plan:The terraform plan command in Terraform is used to generate and show an execution plan, which describes what actions Terraform will take to reach the desired state specified in the configuration files. It provides a preview of what will happen if you apply the configuration.
```
terraform plan
```
Terraform Apply: After reviewing the plan, you can apply the changes. This will execute the plan and apply the changes to your infrastructure. You will be prompted to approve the changes by typing yes or no:
```
terraform apply
```
We can also apply spicific the creation for specific module or resource an example:
```
terraform apply --target=module.mybucketmodule
```
Terraform plan execute the plan to the terminal(dry-run), to make sure you apply only the changes from plan execution you can use the following commands:
```
terraform plan -out=out.plan
terraform apply out.plan
```
Terraform Destroy: To destroy the resources managed by Terraform, run the following command. You will need to approve the destruction by typing yes or no:
```
terraform destroy
```
