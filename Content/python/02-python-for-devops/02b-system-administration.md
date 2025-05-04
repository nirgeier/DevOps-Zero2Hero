<!-- omit in toc -->
# Python for DevOps: System Administration

This guide focuses on using Python for system administration tasks in DevOps. <br>
You'll learn how to monitor systems, create command-line tools, and automate routine administrative tasks.

<br>

<!-- TOC will be generated here -->
## Table of Contents

- [System Administration with Python](#system-administration-with-python)
- [Monitoring and Logging with Python](#monitoring-and-logging-with-python)
- [Creating Command-Line Tools](#creating-command-line-tools)
- [Next Steps](#next-steps)

---

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

This script monitors CPU, memory, and disk usage every 5 seconds for 1 minute. <br>
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

## Next Steps

Now that you've learned about system administration with Python, continue to the next modules:

- **02c-infrastructure-automation.md**: Explore automating cloud resources and infrastructure
- **02d-cicd-error-handling.md**: Discover CI/CD pipeline automation and error handling

You can also revisit the previous module:
- **02a-configuration-management.md**: File operations and working with structured data

Each module builds on the skills from the others to expand your Python DevOps toolkit.

---
