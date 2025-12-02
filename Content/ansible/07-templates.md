<!-- omit in toc -->
# Ansible Templates

- [What are Templates?](#what-are-templates)
  - [Why Use Templates?](#why-use-templates)
- [Jinja2 Basics](#jinja2-basics)
  - [Variables](#variables)
  - [Comments](#comments)
- [Using Templates in Ansible](#using-templates-in-ansible)
  - [The template Module](#the-template-module)
  - [Template File Location](#template-file-location)
- [Jinja2 Filters](#jinja2-filters)
  - [Common Filters](#common-filters)
  - [Chaining Filters](#chaining-filters)
- [Conditionals in Templates](#conditionals-in-templates)
- [Loops in Templates](#loops-in-templates)
- [Practical Examples](#practical-examples)
  - [Example 1: Nginx Configuration](#example-1-nginx-configuration)
  - [Example 2: Hosts File](#example-2-hosts-file)
  - [Example 3: Application Config](#example-3-application-config)
- [Best Practices](#best-practices)

---

## What are Templates?

**In short**: A template is a dynamic file - a file that contains variables which are replaced with actual values at runtime.

Instead of writing:
```plaintext
server_name example.com;
port 80;
```

You write a template:
```plaintext
server_name {{ domain }};
port {{ port }};
```

And when the template is executed, the variables are replaced with the actual values.

---

Templates in Ansible allow you to create dynamic configuration files by combining static content with variables. Instead of maintaining separate configuration files for each server, you can use one template with variables that are replaced at runtime.

Ansible uses the **Jinja2** templating engine, which is a powerful and flexible templating language for Python.

### Why Use Templates?

- **Dynamic Configuration**: Generate files based on variables and facts.
- **Reduce Duplication**: One template for multiple servers with different values.
- **Maintainability**: Update one template instead of many files.
- **Flexibility**: Use conditionals and loops to customize output.

## Jinja2 Basics

### Variables

Variables are enclosed in double curly braces:

```jinja2
Hello {{ username }}!
Server IP: {{ ansible_default_ipv4.address }}
```

### Comments

Comments are enclosed in `{# #}` and won't appear in the output:

```jinja2
{# This is a comment #}
server_name {{ domain_name }};
```

## Using Templates in Ansible

### The template Module

The `template` module processes a Jinja2 template and copies it to the target host.

```yaml
- name: Deploy Nginx configuration
  template:
    src: nginx.conf.j2
    dest: /etc/nginx/nginx.conf
    owner: root
    group: root
    mode: '0644'
```

**Parameters:**
- `src`: Path to the template file (usually ends with `.j2`)
- `dest`: Destination path on the target host
- `owner`, `group`, `mode`: File permissions

### Template File Location

Templates can be stored in two main locations:

**1. Playbook-level templates:**
```plaintext
my-project/
├── playbook.yml
└── templates/
    └── nginx.conf.j2
```

**2. Role-level templates:**
```plaintext
my-project/
├── playbook.yml
└── roles/
    └── nginx/
        └── templates/
            └── nginx.conf.j2
```

When using the `template` module, Ansible automatically searches in the appropriate `templates/` directory based on your context (playbook or role).

## Jinja2 Filters

Filters modify variables. They are applied using the pipe `|` symbol.

### Common Filters

| Filter | Description | Example |
|--------|-------------|---------|
| `default` | Provide a default value | `{{ port \| default(80) }}` |
| `upper` | Convert to uppercase | `{{ name \| upper }}` |
| `lower` | Convert to lowercase | `{{ name \| lower }}` |
| `capitalize` | Capitalize first letter | `{{ name \| capitalize }}` |
| `replace` | Replace substring | `{{ text \| replace('old', 'new') }}` |
| `join` | Join list items | `{{ items \| join(', ') }}` |
| `length` | Get length | `{{ list \| length }}` |
| `int` | Convert to integer | `{{ value \| int }}` |
| `bool` | Convert to boolean | `{{ value \| bool }}` |

#### Chaining Filters

You can chain multiple filters:

```jinja2
{{ username | default('guest') | upper }}
```

## Conditionals in Templates

Use `{% if %}` statements for conditionals:

```jinja2
{% if ansible_os_family == "Debian" %}
    Package manager: apt
{% elif ansible_os_family == "RedHat" %}
    Package manager: yum
{% else %}
    Package manager: unknown
{% endif %}
```

**Comparison operators:**
- `==`, `!=`, `<`, `>`, `<=`, `>=`
- `in`, `not in`
- `is defined`, `is not defined`

## Loops in Templates

Use `{% for %}` to iterate over lists:

```jinja2
{% for user in users %}
    User: {{ user.name }} - {{ user.email }}
{% endfor %}
```

**With conditionals:**

```jinja2
{% for server in servers %}
    {% if server.enabled %}
        server {{ server.name }}:{{ server.port }};
    {% endif %}
{% endfor %}
```

## Practical Examples

### Example 1: Nginx Configuration

**Playbook:**

```yaml
- hosts: webservers
  vars:
    nginx_port: 80
    server_name: example.com
    root_path: /var/www/html
  tasks:
    - name: Deploy Nginx config
      template:
        src: nginx.conf.j2
        dest: /etc/nginx/sites-available/default
```

**Template (nginx.conf.j2):**

```jinja2
server {
    listen {{ nginx_port }};
    server_name {{ server_name }};
    
    root {{ root_path }};
    index index.html index.htm;
    
    location / {
        try_files $uri $uri/ =404;
    }
    
    {# Enable gzip compression #}
    gzip on;
    gzip_types text/plain text/css application/json;
}
```

### Example 2: Hosts File

**Playbook:**

```yaml
- hosts: all
  vars:
    custom_hosts:
      - { ip: "192.168.1.10", hostname: "db.local" }
      - { ip: "192.168.1.11", hostname: "cache.local" }
  tasks:
    - name: Update /etc/hosts
      template:
        src: hosts.j2
        dest: /etc/hosts
        backup: yes
```

**Template (hosts.j2):**

```jinja2
127.0.0.1   localhost
::1         localhost

{# Add custom hosts #}
{% for host in custom_hosts %}
{{ host.ip }}    {{ host.hostname }}
{% endfor %}

{# Add all inventory hosts #}
{% for host in groups['all'] %}
{{ hostvars[host]['ansible_default_ipv4']['address'] }}    {{ host }}
{% endfor %}
```

### Example 3: Application Config

**Playbook:**

```yaml
- hosts: appservers
  vars:
    app_name: myapp
    app_port: 3000
    database:
      host: db.example.com
      port: 5432
      name: myapp_db
    debug_mode: false
    features:
      - authentication
      - caching
      - logging
  tasks:
    - name: Deploy app configuration
      template:
        src: app_config.j2
        dest: /opt/{{ app_name }}/config.yml
```

**Template (app_config.j2):**

```jinja2
# {{ app_name }} Configuration
# Generated by Ansible on {{ ansible_date_time.iso8601 }}

application:
  name: {{ app_name }}
  port: {{ app_port }}
  debug: {{ debug_mode | lower }}

database:
  host: {{ database.host }}
  port: {{ database.port }}
  database: {{ database.name }}
  
features:
{% for feature in features %}
  - {{ feature }}
{% endfor %}

{% if debug_mode %}
# Debug mode is enabled
log_level: DEBUG
{% else %}
log_level: INFO
{% endif %}

# Server information
server_hostname: {{ ansible_hostname }}
server_ip: {{ ansible_default_ipv4.address }}
```

## Best Practices

1. **Use `.j2` extension**: Name template files with `.j2` to distinguish them from regular files.

2. **Add comments**: Document your templates with Jinja2 comments `{# #}`.

3. **Use `default` filter**: Provide default values to avoid undefined variable errors:
   ```jinja2
   {{ port | default(8080) }}
   ```

4. **Validate before deploying**: Use `validate` parameter to check syntax:
   ```yaml
   - name: Deploy Nginx config
     template:
       src: nginx.conf.j2
       dest: /etc/nginx/nginx.conf
       validate: 'nginx -t -c %s'
   ```

5. **Use `backup: yes`**: Create backups when modifying critical files:
   ```yaml
   template:
     src: config.j2
     dest: /etc/app/config
     backup: yes
   ```

6. **Keep templates simple**: If a template becomes too complex, consider splitting it or using includes.

7. **Use whitespace control**: Control whitespace with `-`:
   ```jinja2
   {% for item in items -%}
       {{ item }}
   {%- endfor %}
   ```

8. **Test with different variables**: Test templates with various variable combinations to ensure they work correctly.
