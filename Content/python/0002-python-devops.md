<!-- omit in toc -->
# Python for DevOps

After understanding the basics of Python, we will now go over how Python can be used in DevOps workflows. <br>
This guide demonstrates practical Python applications for infrastructure management, automation, and system operations.

<br>

<!-- TOC will be generated here -->
## Table of Contents

- [Python for DevOps Environments](#python-for-devops-environments)
- [File Operations for Configuration Management](#file-operations-for-configuration-management)
- [Working with Structured Data](#working-with-structured-data)
- [System Administration with Python](#system-administration-with-python)
- [API Interactions for Cloud Resources](#api-interactions-for-cloud-resources)
- [Creating Command-Line Tools](#creating-command-line-tools)
- [Error Handling for Robust Scripts](#error-handling-for-robust-scripts)
- [Next Steps](#next-steps)

---

<br>

## Environment Management with Python

Python is a popular tool in DevOps because it bridges development and operations with clean, maintainable code:

- **Virtual Environments**: Isolate dependencies for different projects
- **Package Management**: Use requirements.txt to ensure consistent environments
- **Project Structure**: Organize code effectively for maintenance and collaboration
- **Version Control Integration**: Work with Git and other VCS systems

Example of setting up a Python environment:

```python
# Navigate to your project directory
# In terminal/command line run:
python -m venv devops-env
source devops-env/bin/activate  # On Windows: devops-env\Scripts\activate

# Install required packages
pip install -r requirements.txt

# Example of a requirements.txt file:
requests==2.32.3
ansible==11.5.0
pyyaml==6.0.2
boto3==1.38.6
```

<br>

## File Operations for Configuration Management

Configuration management is a core DevOps responsibility. Python handles file operations smoothly:

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

<br>

## Working with Structured Data

DevOps engineers frequently work with structured data formats:

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

# Usage
update_service_config('deployment.yaml', 'web-service', 5)
```

<br>

## System Administration with Python

Python can automate routine system administration tasks:

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

<br>

## Error Handling for Robust Scripts

DevOps scripts must be resilient and handle failures gracefully:

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

<br>

## Next Steps

After mastering Python for DevOps:

- Review the dedicated jupyter notebook for hands-on examples
- Explore the next section on Python Automation
- Apply these concepts to build your own DevOps tools
- Dive deeper with the [Python DevOps Jupyter Notebook](./notebooks/python_devops.ipynb)


---