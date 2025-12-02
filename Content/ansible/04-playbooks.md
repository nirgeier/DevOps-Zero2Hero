<!-- omit in toc -->
# Ansible Playbooks

- [What is a Playbook?](#what-is-a-playbook)
- [YAML Syntax](#yaml-syntax)
- [Playbook Structure](#playbook-structure)
- [Example Playbook](#example-playbook)
- [Running a Playbook](#running-a-playbook)
- [Related Labs](#related-labs)


## What is a Playbook?

## YAML Syntax

YAML (YAML Ain't Markup Language) is a human-readable data serialization standard.
- Files start with `---`.
- Indentation is significant (use spaces, not tabs).
- Lists are denoted by hyphens `-`.
- Key-value pairs are separated by a colon `:`.

## Playbook Structure

A playbook is composed of one or more "plays".
- **Play**: Maps a group of hosts to some well-defined roles or tasks.
- **Task**: A call to an Ansible module.

```yaml
---
- name: Update web servers
  hosts: webservers
  become: yes
  
  tasks:
    - name: Ensure apache is at the latest version
      apt:
        name: apache2
        state: latest
```

## Example Playbook

Here is a more complete example that installs and starts Nginx.

```yaml
---
- name: Install and Configure Nginx
  hosts: webservers
  become: yes

  tasks:
    - name: Install Nginx
      apt:
        name: nginx
        state: present
        update_cache: yes

    - name: Start Nginx service
      service:
        name: nginx
        state: started
        enabled: yes

    - name: Create a custom index.html
      copy:
        content: "<h1>Hello from Ansible!</h1>"
        dest: /var/www/html/index.html
```

## Running a Playbook

To run a playbook, use the `ansible-playbook` command:

```bash
ansible-playbook my_playbook.yaml
```

You can also limit execution to a specific host:

```bash
ansible-playbook my_playbook.yaml --limit web1
```

---

## Related Labs

> [!TIP]
> **Practice what you learn!**
> Check out the [Ansible + Vagrant Lab](ansible-labs/ansible+vagrant-lab/README.md) to see real-world playbooks in action.
> *   **Master Playbook**: [master-playbook.yaml](ansible-labs/ansible+vagrant-lab/master-playbook.yaml) orchestrates the entire deployment.
> *   **Backend Playbook**: [backend-playbook.yaml](ansible-labs/ansible+vagrant-lab/backend-playbook.yaml) configures MongoDB.

