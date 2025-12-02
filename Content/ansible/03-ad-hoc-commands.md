<!-- omit in toc -->
# Ansible Ad-Hoc Commands

- [What are Ad-Hoc Commands?](#what-are-ad-hoc-commands)
- [Syntax](#syntax)
- [Common Modules](#common-modules)
  - [Ping](#ping)
  - [Shell / Command](#shell--command)
  - [Package Management (apt/yum)](#package-management-aptyum)
  - [Service Management](#service-management)

## What are Ad-Hoc Commands?

Ad-hoc commands are quick, one-off tasks that you run without writing a playbook. They are useful for quick tests, checking system status, or performing simple operations across your inventory.

## Syntax

The basic syntax for an ad-hoc command is:

```bash
ansible [pattern] -m [module] -a "[module options]"
```

- **pattern**: The host or group from your inventory to target (e.g., `all`, `webservers`).
- **-m [module]**: The Ansible module to run (default is `command`).
- **-a "[options]"**: Arguments to pass to the module.

## Common Modules

### Ping

Check connectivity to your hosts. This doesn't use ICMP ping, but rather verifies that Ansible can login and find a usable Python.

```bash
ansible all -m ping
```

### Shell / Command

Run arbitrary commands on remote systems.

**Command module** (default, safer, no shell variables/pipes):
```bash
ansible webservers -m command -a "uptime"
```

**Shell module** (allows pipes, redirects):
```bash
ansible webservers -m shell -a "echo 'hello' > /tmp/hello.txt"
```

### Package Management (apt/yum)

Install or remove packages.

**Install Nginx on Ubuntu/Debian:**
```bash
ansible webservers -m apt -a "name=nginx state=present" --become
```

**Install Git on CentOS/RHEL:**
```bash
ansible dbservers -m yum -a "name=git state=present" --become
```

*(Note: `--become` is used to escalate privileges, like `sudo`)*

### Service Management

Manage services (start, stop, restart).

**Start Nginx:**
```bash
ansible webservers -m service -a "name=nginx state=started" --become
```

**Restart Apache:**
```bash
ansible webservers -m service -a "name=apache2 state=restarted" --become
```
