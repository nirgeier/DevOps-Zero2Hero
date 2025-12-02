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
