<!-- omit in toc -->
# Python for DevOps

After understanding the basics of Python, let's explore how Python powers DevOps workflows. <br>
This guide demonstrates short but practical Python applications for infrastructure management, automation, and system operations.

<br>

<!-- TOC will be generated here -->
## Table of Contents

- [Why Python for DevOps?](#why-python-for-devops)
- [Python for DevOps Environments](#python-for-devops-environments)
- [File Operations for Configuration Management](#file-operations-for-configuration-management)
- [Working with Structured Data](#working-with-structured-data)
- [System Administration with Python](#system-administration-with-python)
- [API Interactions for Cloud Resources](#api-interactions-for-cloud-resources)
- [Creating Command-Line Tools](#creating-command-line-tools)
- [Python in CI/CD Pipeline Automation](#python-in-cicd-pipeline-automation)
- [Infrastructure as Code (IaC) with Python](#infrastructure-as-code-with-python)
- [Monitoring and Logging with Python](#monitoring-and-logging-with-python)
- [Error Handling for Robust Scripts](#error-handling-for-robust-scripts)
- [Popular Python Libraries for DevOps](#popular-python-libraries-for-devops)
- [Best Practices for Using Python in DevOps](#best-practices-for-using-python-in-devops)
- [Next Steps](#next-steps)

---

<br>

## Why Python for DevOps?

Python has gained significant traction in the DevOps ecosystem due to several compelling reasons:

- **Simplicity**: Easy to learn and read, making automation accessible to all team members
- **Cross-platform compatibility**: Scripts run on Windows, MacOS, Linux, and more
- **Rich ecosystem**: Thousands of libraries for interacting with clouds, containers, and infrastructure
- **Tool integration**: Works seamlessly with Jenkins, Docker, Kubernetes, and cloud platforms
- **Versatility**: Handles everything from simple scripts to complex applications
- **Strong community**: Extensive documentation and community support

As a DevOps practitioner, Python empowers you to automate tasks, integrate systems, and build custom tools that streamline operations.

<br>

## Python for DevOps Environments

Setting up a dedicated Python environment is a crucial step for effective DevOps work. By isolating dependencies for each project, you prevent conflicts between incompatible packages and ensure consistent, reproducible runs.

Key benefits of using environments:

- **Isolation**: Avoid mixing dependencies across projects.
- **Reproducibility**: Ensure the same environment can be recreated anywhere.
- **Stability**: Prevent version conflicts and unexpected behavior.

Common tools for managing Python environments include `venv`, `virtualenv`, and `conda`. Always activate your environment before installing or running project dependencies.

- **Virtual Environments**: Isolate dependencies for different projects
- **Package Management**: Use requirements.txt to ensure consistent environments
- **Project Structure**: Organize code effectively for maintenance and collaboration
- **Version Control Integration**: Work with Git and other VCS systems

Example of setting up a DevOps-friendly Python environment:

```python
# Create and activate a virtual environment
# In terminal/command line:
python -m venv devops-env
source devops-env/bin/activate  # On Windows: devops-env\Scripts\activate

# Install required packages
pip install -r requirements.txt

# Example requirements.txt file:
requests==2.32.3
paramiko==3.5.1
pyyaml==6.0.2
boto3==1.38.6
```

This example creates a virtual environment named `devops-env` and installs the required packages listed in `requirements.txt`. <br>
The `requirements.txt` file specifies the exact versions of packages to ensure consistency across environments. <br>

Output example:

```txt
(devops-env) $ pip install -r requirements.txt
Collecting requests==2.32.3
  Downloading requests-2.32.3-py3-none-any.whl (62 kB)
Collecting paramiko==3.5.1
  Downloading paramiko-3.5.1-py2.py3-none-any.whl (212 kB)
Collecting pyyaml==6.0.1
  Downloading PyYAML-6.0.2-cp310-cp310-manylinux_2_5_x86_64.manylinux1_x86_64.manylinux_2_12_x86_64.manylinux2010_x86_64.whl (682 kB)
Collecting boto3==1.38.6
  Downloading boto3-1.38.6-py3-none-any.whl (132 kB)
Successfully installed boto3-1.38.6 paramiko-3.5.1 pyyaml-6.0.2 requests-2.32.3
```

<br>

## File Operations for Configuration Management

Configuration management is a core DevOps responsibility. <br>
Python handles file operations smoothly, making it ideal for managing configurations and monitoring.

Key file operations include:

- **Reading and writing files**: Process configurations and logs
- **Path manipulation**: Navigate filesystem structures safely
- **File monitoring**: Watch for changes to trigger actions

Example of configuration file handling:

```python
import os
import json

def load_config(config_path):
    """Load configuration from a JSON file."""
    if not os.path.exists(config_path):
        # Create default config if none exists
        default_config = {
            "environment": "development",
            "log_level": "info",
            "services": {
                "web": {"port": 8080, "workers": 4},
                "db": {"port": 5432, "max_connections": 100}
            }
        }
        # Save default configuration
        with open(config_path, 'w') as config_file:
            json.dump(default_config, config_file, indent=4)
        return default_config
    
    # Read existing configuration
    with open(config_path, 'r') as config_file:
        return json.load(config_file)

# Usage
config = load_config('app_config.json')
print(f"Running in {config['environment']} mode")
```
This script loads a JSON configuration file. <br>
If the file doesn't exist, it creates a default configuration. <br>

Output example:

```txt
$ python k8s_config.py
Loading Kubernetes deployment file
Found deployment 'web-service' with 3 replicas
Updated web-service replicas to 5
Configuration saved successfully
```

<br>

## Working with Structured Data

Working with structured data formats is essential for configuration management, data exchange, and reporting.

Common formats include:

- **YAML**: For configuration files (Docker Compose, Kubernetes)
- **JSON**: For API responses and configuration
- **CSV/Excel**: For reports and data processing
- **XML**: For older systems and specific services

Example of YAML processing for infrastructure configuration:

```python
import yaml

def update_service_config(yaml_file, service_name, replicas):
    """Update service replica count in a Kubernetes deployment file."""
    # Load the YAML file
    with open(yaml_file, 'r') as file:
        config = yaml.safe_load(file)
    
    # Update the replica count
    if config['kind'] == 'Deployment' and config['metadata']['name'] == service_name:
        config['spec']['replicas'] = replicas
    
    # Save the updated configuration
    with open(yaml_file, 'w') as file:
        yaml.dump(config, file, default_flow_style=False)
    
    print(f"Updated {service_name} replicas to {replicas}")
    print(yaml.dump(config, default_flow_style=False))

# Usage
update_service_config('deployment.yaml', 'web-service', 5)
```

This script updates the replica count of a Kubernetes deployment in a YAML file. <br>
It uses the `yaml` library to read and write YAML files. <br>
You can run the script to update the replica count of a specific service in the deployment file. <br>

Output example:

```txt
$ python update_service.py
Updated web-service replicas to 5
```

<br>

## System Administration with Python

Python can automate routine system administration tasks and provide information about system performance:

- **Process management**: Start, stop, and monitor processes
- **System information**: Gather metrics about the host system
- **Remote execution**: Run commands on remote servers
- **Service management**: Control system services

Example of system monitoring:

```python
import psutil
import time
from datetime import datetime

def monitor_system(interval=60, duration=3600):
    """Monitor system resources for a specified duration."""
    end_time = time.time() + duration
    
    print(f"Starting system monitoring at {datetime.now().strftime('%H:%M:%S')}")
    print(f"{'Time':<10}{'CPU %':<10}{'Memory %':<10}{'Disk Usage %':<15}")
    
    while time.time() < end_time:
        # Get current metrics
        cpu_percent = psutil.cpu_percent(interval=1)
        memory_percent = psutil.virtual_memory().percent
        disk_percent = psutil.disk_usage('/').percent
        
        # Display current stats
        current_time = datetime.now().strftime('%H:%M:%S')
        print(f"{current_time:<10}{cpu_percent:<10.1f}{memory_percent:<10.1f}{disk_percent:<15.1f}")
        
        # Wait for next check
        time.sleep(interval)

# Usage
# monitor_system(interval=5, duration=60)  # Monitor every 5 seconds for 1 minute
```

this script monitors CPU, memory, and disk usage every 5 seconds for 1 minute. <br>
Output example:

```text
$ python system_monitor.py
Starting system monitoring at 14:32:45
Time      CPU %     Memory %   Disk Usage %   
14:32:46  23.5      42.8       68.2          
14:32:51  26.1      43.0       68.2          
14:32:56  31.2      43.1       68.2          
14:33:01  19.8      43.5       68.3          
14:33:06  22.3      43.6       68.3          
Monitoring complete
```

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

## Creating Command-Line Tools

DevOps engineers often build custom CLI tools for team use:

- **Argument parsing**: Create user-friendly interfaces
- **Interactive prompts**: Guide users through complex operations
- **Progress indicators**: Provide feedback for long-running tasks
- **Colorful output**: Improve readability and highlight important information

Example of building a simple CLI tool:

```python
import argparse
import time
import sys

def create_cli_tool():
    """Create a command-line interface for deployment tasks."""
    parser = argparse.ArgumentParser(description='Deployment tool for services')
    
    # Add arguments
    parser.add_argument('service', choices=['web', 'api', 'database'], help='Service to deploy')
    parser.add_argument('--environment', '-e', choices=['dev', 'staging', 'prod'], default='dev', help='Target environment')
    parser.add_argument('--version', '-v', help='Version to deploy')
    parser.add_argument('--dry-run', action='store_true', help='Show what would be done without actually doing it')
    
    args = parser.parse_args()
    
    # Use the arguments
    print(f"Preparing to deploy {args.service} to {args.environment}")
    
    if args.version:
        print(f"Version: {args.version}")
    else:
        print("No version specified, using latest")
    
    if args.dry_run:
        print("DRY RUN: No changes will be made")
    
    # Simulate deployment with a progress bar
    if not args.dry_run:
        deploy_with_progress()
        print(f"✅ {args.service} successfully deployed to {args.environment}")

def deploy_with_progress():
    """Display a simple progress bar for deployment."""
    print("Deploying: ", end="")
    for i in range(20):
        time.sleep(0.1)  # Simulate work
        sys.stdout.write("▓")
        sys.stdout.flush()
    print(" Done!")

# Usage when run as a script
if __name__ == "__main__":
    create_cli_tool()
```

This script creates a command-line tool for deploying services. <br>
It uses `argparse` for argument parsing and simulates a deployment with a progress bar. <br>

Output example:

```text
$ python deploy.py web --environment staging --version 2.3.4
Preparing to deploy web to staging
Version: 2.3.4
Deploying: ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ Done!
✅ web successfully deployed to staging
```

<br>

## Python in CI/CD Pipeline Automation

Python can automate continuous integration and deployment processes:

- **Build automation**: Trigger builds and compile code
- **Test execution**: Run unit, integration, and acceptance tests
- **Deployment orchestration**: Manage the deployment process
- **Environment validation**: Verify target environments

Example of CI/CD automation with Python:

```python
import subprocess
import requests

def build_application():
    """Build the application."""
    print("Building application...")
    result = subprocess.run(["make", "build"], capture_output=True, text=True)
    
    if result.returncode == 0:
        print("Build successful!")
        return True
    else:
        print(f"Build failed: {result.stderr}")
        return False

def run_tests():
    """Run automated tests."""
    print("Running tests...")
    result = subprocess.run(["pytest", "tests/"], capture_output=True, text=True)
    
    if result.returncode == 0:
        print("All tests passed!")
        return True
    else:
        print(f"Tests failed: {result.stderr}")
        return False

def deploy_to_environment(environment):
    """Deploy to the specified environment."""
    print(f"Deploying to {environment}...")
    
    # Example: Trigger a webhook to start deployment
    webhook_url = f"https://deploy.example.com/environments/{environment}/deploy"
    response = requests.post(webhook_url, json={"version": "1.0.0"})
    
    if response.status_code == 200:
        print(f"Deployment to {environment} initiated successfully")
        return True
    else:
        print(f"Deployment failed: {response.text}")
        return False

# Example CI/CD pipeline
def run_pipeline():
    """Run the full CI/CD pipeline."""
    # Step 1: Build
    if not build_application():
        print("Pipeline failed at build stage")
        return False
    
    # Step 2: Test
    if not run_tests():
        print("Pipeline failed at test stage")
        return False
    
    # Step 3: Deploy to staging
    if not deploy_to_environment("staging"):
        print("Pipeline failed at staging deployment")
        return False
    
    print("Pipeline completed successfully!")
    return True

# Usage
# run_pipeline()

```
This script automates a CI/CD pipeline with build, test, and deployment stages. <br>
It uses `subprocess` to run shell commands and `requests` to trigger a deployment webhook. <br>
You can customize the build and deployment commands as needed. <br>
You can run the pipeline by calling `run_pipeline()`.

Output example:

```text
$ python pipeline.py
Building application...
[INFO] Compiling source files
[INFO] Running webpack build
Build successful!

Running tests...
collected 42 items
................................................
All tests passed!

Deploying to staging...
[INFO] Uploading artifacts to staging server
[INFO] Updating database schema
[INFO] Restarting application services
Deployment to staging initiated successfully

Pipeline completed successfully!
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

## Monitoring and Logging with Python

Python offers powerful tools for monitoring systems and aggregating logs:

- **Metric collection**: Gather performance and health data
- **Log processing**: Parse and analyze log files
- **Alerting**: Send notifications for anomalies or issues
- **Dashboards**: Visualize system status and performance

Example of a simple monitoring script:

```python
import psutil
import time
import logging
import requests
from datetime import datetime

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    filename='monitoring.log'
)
logger = logging.getLogger()

class SystemMonitor:
    """Monitor system resources and send alerts when thresholds are exceeded."""
    
    def __init__(self, cpu_threshold=80, memory_threshold=80, disk_threshold=80):
        self.cpu_threshold = cpu_threshold
        self.memory_threshold = memory_threshold
        self.disk_threshold = disk_threshold
        
        # Store alert statuses to avoid alert flooding
        self.alerts = {
            "cpu": False,
            "memory": False,
            "disk": False
        }
    
    def check_system(self):
        """Check current system resources and return metrics."""
        metrics = {
            "timestamp": datetime.now().isoformat(),
            "cpu_percent": psutil.cpu_percent(interval=1),
            "memory_percent": psutil.virtual_memory().percent,
            "disk_percent": psutil.disk_usage('/').percent
        }
        
        # Log the current metrics
        logger.info(f"CPU: {metrics['cpu_percent']}%, Memory: {metrics['memory_percent']}%, Disk: {metrics['disk_percent']}%")
        
        return metrics
    
    def evaluate_alerts(self, metrics):
        """Check if any metrics exceed thresholds and send alerts."""
        # Check CPU
        if metrics["cpu_percent"] > self.cpu_threshold and not self.alerts["cpu"]:
            self.send_alert("CPU usage is high", metrics["cpu_percent"])
            self.alerts["cpu"] = True
        elif metrics["cpu_percent"] <= self.cpu_threshold and self.alerts["cpu"]:
            self.alerts["cpu"] = False
        
        # Check memory
        if metrics["memory_percent"] > self.memory_threshold and not self.alerts["memory"]:
            self.send_alert("Memory usage is high", metrics["memory_percent"])
            self.alerts["memory"] = True
        elif metrics["memory_percent"] <= self.memory_threshold and self.alerts["memory"]:
            self.alerts["memory"] = False
        
        # Check disk
        if metrics["disk_percent"] > self.disk_threshold and not self.alerts["disk"]:
            self.send_alert("Disk usage is high", metrics["disk_percent"])
            self.alerts["disk"] = True
        elif metrics["disk_percent"] <= self.disk_threshold and self.alerts["disk"]:
            self.alerts["disk"] = False
    
    def send_alert(self, message, value):
        """Send an alert notification."""
        logger.warning(f"ALERT: {message} ({value}%)")
        
        # In a real system, you might send an email, SMS, or call a webhook
        # Example webhook call:
        # requests.post(
        #     "https://alerts.example.com/webhook",
        #     json={"message": message, "value": value}
        # )
    
    def start_monitoring(self, interval=60, duration=None):
        """Start the monitoring loop."""
        logger.info(f"Starting system monitoring with interval {interval}s")
        
        end_time = time.time() + duration if duration else None
        
        try:
            while True:
                # Check if duration has elapsed
                if end_time and time.time() > end_time:
                    break
                
                # Check system and evaluate alerts
                metrics = self.check_system()
                self.evaluate_alerts(metrics)
                
                # Wait for next interval
                time.sleep(interval)
        
        except KeyboardInterrupt:
            logger.info("Monitoring stopped by user")
        except Exception as e:
            logger.error(f"Error in monitoring: {str(e)}")
        finally:
            logger.info("Monitoring stopped")

# Usage
# monitor = SystemMonitor(cpu_threshold=70)
# monitor.start_monitoring(interval=5)
```

This script monitors CPU, memory, and disk usage every 5 seconds. <br>
It logs metrics and sends alerts if thresholds are exceeded. <br>
The `SystemMonitor` class encapsulates the monitoring logic, including checking system resources, evaluating alerts, and sending notifications. <br>
You can customize the thresholds and monitoring interval as needed. <br>
The script uses the `psutil` library to gather system metrics and the `logging` module for logging. <br>
You can also integrate with external alerting systems by uncommenting the webhook call in the `send_alert` method.
You can run the script in the background or as part of a larger monitoring system. <br>
You can also modify the `send_alert` method to send notifications via email, SMS, or other channels.

Output example:

```text
$ python monitoring.py
2025-05-01 15:23:45 - INFO - Starting system monitoring with interval 5s
2025-05-01 15:23:46 - INFO - CPU: 32.6%, Memory: 67.2%, Disk: 75.1%
2025-05-01 15:23:51 - INFO - CPU: 45.8%, Memory: 68.4%, Disk: 75.1%
2025-05-01 15:23:56 - INFO - CPU: 87.3%, Memory: 69.1%, Disk: 75.1%
2025-05-01 15:23:56 - WARNING - ALERT: CPU usage is high (87.3%)
2025-05-01 15:24:01 - INFO - CPU: 74.2%, Memory: 72.5%, Disk: 75.1%
2025-05-01 15:24:06 - INFO - CPU: 62.1%, Memory: 89.4%, Disk: 75.1%
2025-05-01 15:24:06 - WARNING - ALERT: Memory usage is high (89.4%)
2025-05-01 15:24:11 - INFO - CPU: 54.3%, Memory: 81.2%, Disk: 75.1%
2025-05-01 15:24:16 - INFO - Monitoring stopped by user
```

<br>

## Error Handling for Robust Scripts

Production ready scripts must be resilient and handle failures gracefully in order to avoid downtime and data loss. 

<br>

key strategies include:

- **Try/except blocks**: Catch and handle exceptions
- **Comprehensive exception handling**: Plan for various failure modes
- **Logging**: Record detailed information for troubleshooting
- **Retry mechanisms**: Attempt operations multiple times before failing
- **Graceful degradation**: Continue partial operation when possible

Example of robust error handling and logging:

```python
import logging
import time
import random

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    filename='deployment.log'
)

def retry_operation(operation, max_attempts=3, backoff_factor=2):
    """Retry an operation with exponential backoff."""
    attempt = 1
    last_exception = None
    
    while attempt <= max_attempts:
        try:
            logging.info(f"Attempt {attempt} of {operation.__name__}")
            result = operation()
            logging.info(f"Operation {operation.__name__} succeeded")
            return result
        except Exception as e:
            last_exception = e
            wait_time = backoff_factor ** (attempt - 1)
            logging.warning(f"Attempt {attempt} failed: {str(e)}")
            logging.info(f"Waiting {wait_time} seconds before retry")
            time.sleep(wait_time)
            attempt += 1
    
    # If we get here, all attempts failed
    logging.error(f"All {max_attempts} attempts of {operation.__name__} failed")
    raise last_exception

# Example operation that might fail
def deploy_service():
    """Deploy a service that might randomly fail."""
    if random.random() < 0.7:  # 70% chance of failure
        raise ConnectionError("Deployment server connection failed")
    return "Deployment successful"

# Usage
try:
    result = retry_operation(deploy_service)
    print(result)
except Exception as e:
    print(f"Deployment failed: {str(e)}")
```

This script retries the `deploy_service` function up to 3 times with exponential backoff if it fails. <br>
`retry_operation` handles the retry logic and logs each attempt. <br>
`deploy_service` simulates a deployment that may fail randomly.
The script logs each attempt and waits longer between retries.

Output example:

```txt
$ python robust_deploy.py
2025-05-01 15:30:22 - INFO - Attempt 1 of deploy_service
2025-05-01 15:30:22 - WARNING - Attempt 1 failed: Deployment server connection failed
2025-05-01 15:30:22 - INFO - Waiting 1 seconds before retry
2025-05-01 15:30:23 - INFO - Attempt 2 of deploy_service
2025-05-01 15:30:23 - WARNING - Attempt 2 failed: Deployment server connection failed
2025-05-01 15:30:23 - INFO - Waiting 2 seconds before retry
2025-05-01 15:30:25 - INFO - Attempt 3 of deploy_service
2025-05-01 15:30:25 - INFO - Operation deploy_service succeeded
Deployment successful
```

<br>

## Popular Python Libraries for DevOps

Several Python libraries are essential tools in a DevOps engineer's toolkit:

- **Boto3**: AWS resource management
- **Requests**: For HTTP requests and API interaction
- **Paramiko**: For SSH connections and remote execution
- **PyYAML**: For parsing YAML configurations
- **Fabric**: For streamlining SSH use
- **Docker SDK**: For Docker container management
- **Kubernetes**: For managing Kubernetes clusters
- **Ansible**: For configuration management (uses Python)
- **Prometheus Client**: For metrics collection
- **Flask**: For building lightweight web services

<br>

## Best Practices for Using Python in DevOps

Follow these practices to ensure your Python DevOps scripts are reliable and maintainable:

- **Use Virtual Environments**: Keep dependencies isolated for each project
- **Document Your Code**: Include comments, docstrings, and README files
- **Follow a Consistent Style**: Use tools like flake8 and black for formatting
- **Implement Comprehensive Testing**: Unit and integration tests for automation scripts
- **Use Environment Variables**: Never hardcode credentials or sensitive information
- **Implement Proper Error Handling**: Make scripts robust against failures
- **Monitor Script Execution**: Log operations and track performance
- **Version Control**: Store scripts in Git repositories
- **Peer Review**: Have team members review automation code
- **Modular Design**: Break complex automation into reusable functions

<br>

## Next Steps

After mastering Python for DevOps:

- Review the dedicated jupyter notebook for hands-on examples
- Explore the next section on Python Automation
- Apply these concepts to build your own DevOps tools
- Dive deeper with the [Python DevOps Jupyter Notebook](./notebooks/python_devops.ipynb)


---
