<!-- omit in toc -->
# Ansible Conditionals and Loops

- [Conditionals](#conditionals)
  - [The `when` Statement](#the-when-statement)
  - [Conditionals with Variables](#conditionals-with-variables)
- [Loops](#loops)
  - [Standard Loops](#standard-loops)
  - [Looping over Hashes](#looping-over-hashes)

---

## Conditionals

Conditionals allow you to execute tasks only when certain conditions are met.

### The `when` Statement

The most common conditional is the `when` statement.

```yaml
- name: Install Apache on Debian
  apt:
    name: apache2
    state: present
  when: ansible_os_family == "Debian"

- name: Install Httpd on RedHat
  yum:
    name: httpd
    state: present
  when: ansible_os_family == "RedHat"
```

### Conditionals with Variables

You can also use your own variables in conditionals.

```yaml
vars:
  production: true

tasks:
  - name: Restart web server
    service:
      name: apache2
      state: restarted
    when: production
```

## Loops

Loops allow you to repeat a task multiple times.

### Standard Loops

Use the `loop` keyword to iterate over a list.

```yaml
- name: Add several users
  user:
    name: "{{ item }}"
    state: present
    groups: "wheel"
  loop:
    - testuser1
    - testuser2
```

### Looping over Hashes

You can also loop over a list of dictionaries (hashes).

```yaml
- name: Add several users with specific uids
  user:
    name: "{{ item.name }}"
    uid: "{{ item.uid }}"
    state: present
  loop:
    - { name: 'testuser1', uid: 1002 }
    - { name: 'testuser2', uid: 1003 }
```
