<!-- omit in toc -->
# Ansible Variables

- [Defining Variables](#defining-variables)
  - [In Playbooks](#in-playbooks)
  - [In Inventory](#in-inventory)
  - [In Variable Files](#in-variable-files)
- [Registered Variables](#registered-variables)
- [Magic Variables](#magic-variables)
- [Variable Precedence](#variable-precedence)

---

## Defining Variables

Variables allow you to manage differences between systems without changing your playbooks.

### In Playbooks

You can define variables directly in a playbook using the `vars` block.

```yaml
- hosts: webservers
  vars:
    http_port: 80
    max_clients: 200
  tasks:
    ...
```

### In Inventory

As seen in the Inventory module, you can define variables in your inventory file.

```ini
[webservers]
web1 http_port=80
web2 http_port=8080
```

### In Variable Files

It's often better to keep variables in separate files to keep your playbooks clean and organized. You can include them in your playbook using `vars_files`.

**1. Create a variable file (e.g., `vars/external_vars.yml`):**

```yaml
# vars/external_vars.yml
http_port: 80
max_clients: 200
```

**2. Import it in your Playbook:**

```yaml
- hosts: webservers
  vars_files:
    - vars/external_vars.yml
  tasks:
    - name: Print variable
      debug:
        msg: "Port is {{ http_port }}"
```

## Registered Variables

You can capture the output of a task into a variable using the `register` keyword.

```yaml
- hosts: webservers
  tasks:
    - name: Run a command
      command: uptime
      register: uptime_result

    - name: Print the result
      debug:
        var: uptime_result.stdout
```

## Magic Variables

Ansible provides some variables automatically, known as "magic variables".
- `hostvars`: Access variables from other hosts.
- `groups`: List of groups and their hosts.
- `group_names`: List of groups the current host is in.
- `inventory_hostname`: The hostname as defined in the inventory.

## Variable Precedence

Ansible has a specific order of precedence for variables. In general:
1. Extra vars (`-e` in command line) - **Highest**
2. Playbook vars
3. Inventory vars
4. Role defaults - **Lowest**
