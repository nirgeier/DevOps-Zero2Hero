<!-- omit in toc -->
# Python for DevOps: Infrastructure Automation

This guide focuses on using Python to automate infrastructure tasks in DevOps. <br>
You'll learn how to interact with cloud APIs and implement Infrastructure as Code (IaC) practices.

<br>

<!-- TOC will be generated here -->
## Table of Contents

- [API Interactions for Cloud Resources](#api-interactions-for-cloud-resources)
- [Infrastructure as Code (IaC) with Python](#infrastructure-as-code-iac-with-python)
- [Next Steps](#next-steps)

---

<br>

## API Interactions for Cloud Resources

Modern DevOps heavily utilizes cloud services through APIs:

- **RESTful services**: Interact with cloud providers and services
- **Authentication**: Securely access protected resources
- **Resource management**: Create, update, and delete cloud resources
- **Status monitoring**: Check health and availability of services

Example of working with cloud resources via API:

```python
import requests
import os

def get_cloud_instances(api_key, region):
    """List cloud instances in a specific region."""
    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json"
    }
    
    url = f"https://api.cloudprovider.com/v1/instances?region={region}"
    
    response = requests.get(url, headers=headers)
    
    if response.status_code == 200:
        instances = response.json()
        print(f"Found {len(instances)} instances in {region}:")
        
        for i, instance in enumerate(instances, 1):
            print(f"{i}. {instance['name']} - {instance['type']} - {instance['status']}")
        
        return instances
    else:
        print(f"Error: {response.status_code} - {response.text}")
        return []

# Usage
# API_KEY = os.environ.get('CLOUD_API_KEY')
# instances = get_cloud_instances(API_KEY, 'us-west-1')
```

This script retrieves a list of cloud instances in a specified region using an API key stored in an environment variable.

Output example:

```text
$ python cloud_api.py
Authenticating with cloud provider API...
Found 3 instances in us-west-1:
1. web-server-01 - t2.micro - running
2. app-server-01 - t2.small - running
3. db-server-01 - t2.medium - stopped
```

<br>

## Infrastructure as Code (IaC) with Python

Python can programmatically manage infrastructure across various cloud providers. <br>
IaC allows you to define and provision infrastructure using code, making it easier to manage and version control.

Key benefits of IaC:

- **Resource provisioning**: Create servers, networks, and storage
- **Infrastructure scaling**: Add or remove resources based on demand
- **Configuration drift detection**: Identify and correct unexpected changes
- **Multi-cloud management**: Standardize operations across providers

Example of AWS infrastructure management with boto3:

```python
import boto3
import time

class InfrastructureManager:
    """Manage cloud infrastructure with Python."""
    
    def __init__(self, region="us-west-2"):
        self.ec2 = boto3.resource('ec2', region_name=region)
        self.ec2_client = boto3.client('ec2', region_name=region)
        self.region = region
    
    def create_vpc(self, cidr_block, name):
        """Create a new VPC."""
        vpc = self.ec2.create_vpc(CidrBlock=cidr_block)
        
        # Add a name tag to the VPC
        vpc.create_tags(Tags=[{"Key": "Name", "Value": name}])
        
        # Enable DNS support
        vpc.modify_attribute(EnableDnsSupport={'Value': True})
        vpc.modify_attribute(EnableDnsHostnames={'Value': True})
        
        print(f"Created VPC {vpc.id} with name {name}")
        return vpc
    
    def create_subnet(self, vpc_id, cidr_block, name, availability_zone=None):
        """Create a subnet in the VPC."""
        create_args = {
            'VpcId': vpc_id,
            'CidrBlock': cidr_block
        }
        
        if availability_zone:
            create_args['AvailabilityZone'] = availability_zone
            
        subnet = self.ec2.create_subnet(**create_args)
        
        # Add a name tag to the subnet
        subnet.create_tags(Tags=[{"Key": "Name", "Value": name}])
        
        print(f"Created subnet {subnet.id} with name {name}")
        return subnet
    
    def create_security_group(self, vpc_id, name, description):
        """Create a security group."""
        security_group = self.ec2.create_security_group(
            GroupName=name,
            Description=description,
            VpcId=vpc_id
        )
        
        print(f"Created security group {security_group.id} with name {name}")
        return security_group
    
    def create_ec2_instance(self, subnet_id, security_group_id, instance_type, ami_id, key_name, name):
        """Create an EC2 instance."""
        instances = self.ec2.create_instances(
            ImageId=ami_id,
            InstanceType=instance_type,
            KeyName=key_name,
            MaxCount=1,
            MinCount=1,
            NetworkInterfaces=[
                {
                    'SubnetId': subnet_id,
                    'DeviceIndex': 0,
                    'AssociatePublicIpAddress': True,
                    'Groups': [security_group_id]
                }
            ]
        )
        
        instance = instances[0]
        
        # Add a name tag to the instance
        instance.create_tags(Tags=[{"Key": "Name", "Value": name}])
        
        # Wait for the instance to be running
        instance.wait_until_running()
        
        # Reload the instance attributes
        instance.reload()
        
        print(f"Created EC2 instance {instance.id} with name {name}")
        print(f"Public IP: {instance.public_ip_address}")
        
        return instance

# Usage
# infra_manager = InfrastructureManager()
# vpc = infra_manager.create_vpc('10.0.0.0/16', 'DevOpsVPC')
# subnet = infra_manager.create_subnet(vpc.id, '10.0.1.0/24', 'DevOpsSubnet')
```

This script uses the `boto3` library to create a VPC, subnet, security group, and EC2 instance in AWS. <br>
It demonstrates how to manage cloud resources programmatically. <br>

Output example:

```text
$ python aws_manager.py
AWS credentials loaded from environment
Creating VPC vpc-0a1b2c3d4e5f6g7h8 with name DevOpsVPC
Enabling DNS hostnames for vpc-0a1b2c3d4e5f6g7h8
Creating subnet subnet-0a1b2c3d4e5f6g7h8 with name DevOpsSubnet
Creating security group sg-0a1b2c3d4e5f6g7h8 with name DevOpsSecurityGroup
Creating EC2 instance i-0a1b2c3d4e5f6g7h8 with name WebServer
Waiting for instance to start...
Instance is running
Public IP: 54.123.45.67
```

<br>

## Next Steps

Now that you've learned about infrastructure automation with Python, continue to the next module:

- **02d-cicd-error-handling.md**: Discover CI/CD pipeline automation and error handling

You can also revisit the previous modules:
- **02a-configuration-management.md**: File operations and working with structured data
- **02b-system-administration.md**: System monitoring and command-line tools

Each module builds on the skills from the others to expand your Python DevOps toolkit.

---
