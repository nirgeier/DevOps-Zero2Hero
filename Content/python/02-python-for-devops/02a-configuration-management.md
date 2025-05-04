<!-- omit in toc -->
# Python for DevOps: Configuration Management

After understanding the basics of Python, let's explore how Python handles configuration management tasks in DevOps workflows. <br>
This guide focuses on file operations and working with structured data - critical skills for managing configurations in various environments.

<br>

<!-- TOC will be generated here -->
## Table of Contents

- [Why Python for DevOps?](#why-python-for-devops)
- [Python for DevOps Environments](#python-for-devops-environments)
- [File Operations for Configuration Management](#file-operations-for-configuration-management)
- [Working with Structured Data](#working-with-structured-data)
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

## Next Steps

Now that you've learned about configuration management with Python, continue to the next modules:

- **02b-system-administration.md**: Learn how to manage and monitor systems using Python
- **02c-infrastructure-automation.md**: Explore automating cloud resources and infrastructure
- **02d-cicd-error-handling.md**: Discover CI/CD pipeline automation and error handling

Each module builds on the skills from this one to expand your Python DevOps toolkit.

---
