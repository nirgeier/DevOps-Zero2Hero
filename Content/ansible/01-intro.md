<!-- omit in toc -->
# Introduction to Ansible

- [What is Ansible?](#what-is-ansible)
- [Core Concepts](#core-concepts)
- [Architecture](#architecture)
- [Installation](#installation)



## What is Ansible?

Ansible is an open-source software provisioning, configuration management, and application-deployment tool enabling infrastructure as code. It runs on many Unix-like systems, and can configure both Unix-like systems as well as Microsoft Windows.

Ansible is agentless, temporarily connecting remotely via SSH or Windows Remote Management (allowing remote PowerShell execution) to do its tasks.

## Core Concepts

### Inventory

Ansible works against multiple managed nodes or "hosts" in your infrastructure at the same time, using a list or group of lists known as inventory. You can pass inventory once at the command line, but most Ansible users create a file and keep it in their repo.

### Modules

Ansible works by connecting to your nodes and pushing out small programs, called "modules" to them. These programs are written to be resource models of the desired state of the system. Ansible executes these modules (over SSH by default), and removes them when finished.

### Playbooks

Playbooks are Ansible’s configuration, deployment, and orchestration language. They can describe a policy you want your remote systems to enforce, or a set of steps in a general IT process.

## Architecture

Ansible's architecture is simple and effective. It relies on:
- **Control Node**: The machine where Ansible is installed and from which you run commands.
- **Managed Nodes**: The devices (servers, network devices, etc.) that you manage with Ansible.
- **Plugins**: Code that expands Ansible's core functionality.
- **Inventory**: A list of managed nodes.
- **Playbooks**: YAML files containing the definition of automation.

## Installation

To install Ansible, you generally need Python installed on your control node.

```bash
sudo apt update
sudo apt install ansible
```

## Resources

- [Official Ansible Documentation](https://docs.ansible.com/)
