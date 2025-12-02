<!-- omit in toc -->
# Ansible Roles

- [What are Roles?](#what-are-roles)
  - [Why Use Roles?](#why-use-roles)
- [Role Structure](#role-structure)
  - [Directory Breakdown](#directory-breakdown)
- [Creating Roles](#creating-roles)
  - [Manual Creation](#manual-creation)
  - [Using ansible-galaxy](#using-ansible-galaxy)
- [Using Roles](#using-roles)
  - [Basic Usage](#basic-usage)
  - [Passing Variables to Roles](#passing-variables-to-roles)
  - [Role Dependencies](#role-dependencies)
- [Complete Example: Nginx Role](#complete-example-nginx-role)
  - [Step 1: Create the Role Structure](#step-1-create-the-role-structure)
  - [Step 2: Define Tasks](#step-2-define-tasks)
  - [Step 3: Create Handlers](#step-3-create-handlers)
  - [Step 4: Set Variables](#step-4-set-variables)
  - [Step 5: Create Templates](#step-5-create-templates)
  - [Step 6: Use the Role](#step-6-use-the-role)
- [Ansible Galaxy](#ansible-galaxy)
  - [Installing Roles from Galaxy](#installing-roles-from-galaxy)
  - [Searching for Roles](#searching-for-roles)
- [Best Practices](#best-practices)

---

## What are Roles?

Roles are Ansible's way of organizing playbooks into reusable components. Instead of writing one massive playbook with hundreds of tasks, you can break your automation into logical, self-contained units called roles.

Think of a role as a "package" that contains everything needed to configure a specific service or component (like Nginx, MySQL, or a firewall).

### Why Use Roles?

- **Reusability**: Write once, use in multiple playbooks or projects.
- **Organization**: Keep related tasks, variables, and files together.
- **Sharing**: Easily share roles with your team or the community via Ansible Galaxy.
- **Maintainability**: Easier to update and debug when code is organized.

## Role Structure

A role has a standardized directory structure. Ansible automatically knows where to find tasks, variables, handlers, etc., based on this structure.

```
roles/
  my_role/
    tasks/
      main.yml
    handlers/
      main.yml
    templates/
    files/
    vars/
      main.yml
    defaults/
      main.yml
    meta/
      main.yml
    README.md
```

### Directory Breakdown

| Directory | Purpose | Example |
|-----------|---------|---------|
| **tasks/** | Main list of tasks to execute | Install packages, start services |
| **handlers/** | Tasks triggered by `notify` | Restart a service after config change |
| **templates/** | Jinja2 templates (.j2 files) | Configuration files with variables |
| **files/** | Static files to copy to hosts | Scripts, certificates, config files |
| **vars/** | Variables with higher priority | Role-specific settings |
| **defaults/** | Default variables (lowest priority) | Fallback values |
| **meta/** | Role metadata and dependencies | Specify other roles this depends on |

**Important Notes:**
- Each directory should contain a `main.yml` file (except `files/` and `templates/`).
- Ansible automatically loads `tasks/main.yml`, `handlers/main.yml`, etc.
- You can split tasks into multiple files and include them from `main.yml`.

## Creating Roles

### Manual Creation

You can manually create the directory structure:

```bash
mkdir -p roles/nginx/{tasks,handlers,templates,files,vars,defaults,meta}
touch roles/nginx/tasks/main.yml
```

### Using ansible-galaxy

The recommended way is to use `ansible-galaxy init`:

```bash
ansible-galaxy init roles/nginx
```

This creates the complete structure with placeholder files.

## Using Roles

### Basic Usage

To use a role in a playbook, list it under the `roles` section:

```yaml
---
- hosts: webservers
  become: yes
  roles:
    - nginx
    - firewall
```

Ansible will look for roles in:
1. `./roles/` (relative to the playbook)
2. `/etc/ansible/roles/`
3. Paths defined in `ansible.cfg`

### Passing Variables to Roles

You can pass variables to roles in several ways:

**Method 1: Inline variables**

```yaml
- hosts: webservers
  roles:
    - role: nginx
      nginx_port: 8080
      nginx_user: www-data
```

**Method 2: Using vars**

```yaml
- hosts: webservers
  vars:
    nginx_port: 8080
  roles:
    - nginx
```

**Method 3: In inventory**

```ini
[webservers]
web1 nginx_port=8080
```

### Role Dependencies

Roles can depend on other roles. Define dependencies in `meta/main.yml`:

```yaml
---
dependencies:
  - role: common
  - role: firewall
    firewall_allowed_ports:
      - 80
      - 443
```

When you use a role with dependencies, Ansible automatically runs the dependent roles first.

## Complete Example: Nginx Role

Let's build a complete Nginx role step by step.

### Step 1: Create the Role Structure

```bash
ansible-galaxy init roles/nginx
```

This creates:

```
roles/nginx/
├── defaults/
│   └── main.yml
├── files/
├── handlers/
│   └── main.yml
├── meta/
│   └── main.yml
├── tasks/
│   └── main.yml
├── templates/
└── vars/
    └── main.yml
```

### Step 2: Define Tasks

Edit `roles/nginx/tasks/main.yml`:

```yaml
---
# Install Nginx
- name: Install Nginx package
  apt:
    name: nginx
    state: present
    update_cache: yes
  when: ansible_os_family == "Debian"

- name: Install Nginx on RedHat
  yum:
    name: nginx
    state: present
  when: ansible_os_family == "RedHat"

# Deploy custom configuration
- name: Deploy Nginx configuration
  template:
    src: nginx.conf.j2
    dest: /etc/nginx/nginx.conf
    owner: root
    group: root
    mode: '0644'
  notify: Restart Nginx

# Deploy custom index page
- name: Deploy custom index page
  template:
    src: index.html.j2
    dest: /var/www/html/index.html
    owner: www-data
    group: www-data
    mode: '0644'

# Ensure Nginx is running
- name: Ensure Nginx is started and enabled
  service:
    name: nginx
    state: started
    enabled: yes
```

### Step 3: Create Handlers

Edit `roles/nginx/handlers/main.yml`:

```yaml
---
- name: Restart Nginx
  service:
    name: nginx
    state: restarted

- name: Reload Nginx
  service:
    name: nginx
    state: reloaded
```

**What are handlers?**
Handlers are special tasks that only run when notified by another task. They run at the end of the play, and only once even if notified multiple times.

### Step 4: Set Variables

Edit `roles/nginx/defaults/main.yml`:

```yaml
---
nginx_port: 80
nginx_user: www-data
welcome_message: "Welcome to Nginx configured by Ansible!"
```

Edit `roles/nginx/vars/main.yml`:

```yaml
---
nginx_config_path: /etc/nginx/nginx.conf
```

**Difference between `defaults` and `vars`:**
- `defaults/`: Lowest priority, easily overridden.
- `vars/`: Higher priority, harder to override.

### Step 5: Create Templates

Create `roles/nginx/templates/nginx.conf.j2`:

```nginx
user {{ nginx_user }};
worker_processes auto;

events {
    worker_connections 1024;
}

http {
    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    server {
        listen {{ nginx_port }};
        server_name _;

        location / {
            root /var/www/html;
            index index.html;
        }
    }
}
```

Create `roles/nginx/templates/index.html.j2`:

```html
<!DOCTYPE html>
<html>
<head>
    <title>Ansible Nginx</title>
</head>
<body>
    <h1>{{ welcome_message }}</h1>
    <p>Server: {{ inventory_hostname }}</p>
    <p>Port: {{ nginx_port }}</p>
</body>
</html>
```

### Step 6: Use the Role

Create a playbook `site.yml`:

```yaml
---
- name: Configure web servers
  hosts: webservers
  become: yes
  
  roles:
    - role: nginx
      nginx_port: 8080
      welcome_message: "Hello from my custom Nginx server!"
```

Run it:

```bash
ansible-playbook -i inventory site.yml
```

## Ansible Galaxy

Ansible Galaxy is a public repository where the community shares roles.

### Installing Roles from Galaxy

```bash
# Install a specific role
ansible-galaxy install geerlingguy.nginx

# Install to a specific directory
ansible-galaxy install geerlingguy.nginx -p ./roles

# Install from requirements file
ansible-galaxy install -r requirements.yml
```

**requirements.yml example:**

```yaml
---
- name: geerlingguy.nginx
  version: 3.1.4

- name: geerlingguy.mysql
```

### Searching for Roles

```bash
# Search for roles
ansible-galaxy search nginx

# Get info about a role
ansible-galaxy info geerlingguy.nginx
```

## Best Practices

1. **Use `defaults/` for variables**: Make your roles configurable with sensible defaults.
2. **Document your roles**: Add a `README.md` explaining variables and usage.
3. **Keep roles focused**: One role = one responsibility (e.g., nginx, mysql, not "webserver").
4. **Use handlers**: Don't restart services unnecessarily.
5. **Test your roles**: Use Molecule or similar tools to test roles.
6. **Version your roles**: Use Git tags for versioning.
7. **Use `meta/main.yml`**: Document dependencies and metadata.
