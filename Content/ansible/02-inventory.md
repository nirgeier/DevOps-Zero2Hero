<!-- omit in toc -->
# Ansible Inventory

- [What is Inventory?](#what-is-inventory)
- [Inventory Formats](#inventory-formats)
  - [INI Format](#ini-format)
  - [YAML Format](#yaml-format)
- [Groups and Variables](#groups-and-variables)
- [Default Location](#default-location)



## What is Inventory?

The Ansible inventory is a file (or multiple files) that contains a list of the servers or nodes you want to manage. It allows you to organize your managed nodes into groups, which makes it easier to run automation against specific sets of servers (e.g., "webservers", "dbservers").

## Inventory Formats

Ansible supports multiple formats for inventory, but the most common are **INI** and **YAML**.

### INI Format

The INI format is simple and easy to read.

```ini
mail.example.com

[webservers]
foo.example.com
bar.example.com

[dbservers]
one.example.com
two.example.com
```

### YAML Format

The YAML format is more structured and consistent with Playbooks.

```yaml
all:
  hosts:
    mail.example.com:
  children:
    webservers:
      hosts:
        foo.example.com:
        bar.example.com:
    dbservers:
      hosts:
        one.example.com:
        two.example.com:
```

## Groups and Variables

You can assign variables to hosts or groups in your inventory.

### Host Variables

```ini
[webservers]
web1 http_port=80 maxRequestsPerChild=808
web2 http_port=303 maxRequestsPerChild=909
```

### Group Variables

```ini
[webservers]
web1
web2

[webservers:vars]
ntp_server=ntp.atlanta.example.com
proxy=proxy.atlanta.example.com
```

## Default Location

The default location for the inventory file is `/etc/ansible/hosts`, but you can specify a different inventory file using the `-i` flag when running Ansible commands.

```bash
ansible all -i my_inventory_file -m ping
```
