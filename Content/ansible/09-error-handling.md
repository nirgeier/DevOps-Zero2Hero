<!-- omit in toc -->
# Ansible Error Handling

- [Ignoring Errors](#ignoring-errors)
- [Defining Failure Conditions](#defining-failure-conditions)
  - [failed_when](#failed_when)
  - [changed_when](#changed_when)
- [Blocks, Rescue, and Always](#blocks-rescue-and-always)
  - [Block Structure](#block-structure)
  - [Example: Recovery Mechanism](#example-recovery-mechanism)
- [Debugging Strategies](#debugging-strategies)
  - [The debug module](#the-debug-module)
  - [Verbose Mode](#verbose-mode)
  - [Playbook Debugger](#playbook-debugger)



## Ignoring Errors

By default, Ansible stops executing tasks on a host if a task fails. Sometimes, you want to continue execution even if a specific task fails.

Use `ignore_errors: yes` to achieve this.

```yaml
- name: This task will fail but playbook continues
  command: /bin/false
  ignore_errors: yes

- name: This task will run
  debug:
    msg: "I am running even though the previous task failed!"
```

> [!WARNING]
> Use `ignore_errors` sparingly. It can hide actual problems in your automation.

---

## Defining Failure Conditions

Ansible decides if a task failed based on the return code. You can override this behavior.

### failed_when

You can define custom failure conditions using `failed_when`.

```yaml
- name: Check if file exists
  command: cat /tmp/myfile
  register: result
  failed_when: "'CRITICAL' in result.stdout"
  ignore_errors: yes
```

In this example, the task only "fails" if the word "CRITICAL" is in the output, regardless of the exit code.

### changed_when

Ansible reports "changed" if a task modifies the system. Sometimes commands run successfully but don't actually change anything (e.g., a check command).

```yaml
- name: Check service status
  command: service nginx status
  register: service_status
  changed_when: false
```

This ensures the task reports "ok" (green) instead of "changed" (yellow), keeping your playbook output clean.

---

## Blocks, Rescue, and Always

Blocks allow you to group tasks together and apply error handling logic, similar to `try/catch/finally` in programming languages.

### Block Structure

- **block**: The main tasks to execute.
- **rescue**: Tasks to run *only* if a task in the `block` fails.
- **always**: Tasks that run *no matter what* (success or failure).

### Example: Recovery Mechanism

```yaml
- name: Attempt to upgrade database
  block:
    - name: Upgrade database schema
      command: /usr/local/bin/upgrade-db.sh
      
    - name: Restart database service
      service:
        name: postgresql
        state: restarted

  rescue:
    - name: Revert database schema (on failure)
      command: /usr/local/bin/revert-db.sh
      
    - name: Send alert to Slack
      uri:
        url: https://hooks.slack.com/services/xxx/yyy
        method: POST
        body: '{"text": "Database upgrade failed! Reverted changes."}'
        body_format: json

  always:
    - name: Clean up temporary files
      file:
        path: /tmp/db_upgrade.log
        state: absent
```

---

## Debugging Strategies

### The debug module

The most common way to debug is printing variables.

```yaml
- name: Print a variable
  debug:
    var: result.stdout

- name: Print a custom message
  debug:
    msg: "The value of x is {{ x }}"
```

### Verbose Mode

When running playbooks, increase verbosity to see more details:

- `-v`: Show task results.
- `-vv`: Show task results and input configuration.
- `-vvv`: Show connection information.
- `-vvvv`: Connection debugging (SSH level).

```bash
ansible-playbook site.yml -vv
```

### Playbook Debugger

Ansible has an interactive debugger. You can enable it on failure.

```yaml
- name: Task that might fail
  command: /bin/false
  debugger: on_failed
```

When this task fails, Ansible drops you into an interactive shell where you can inspect variables and retry the task.

```text
[host1] TASK: Task that might fail (debug)> p result
...
[host1] TASK: Task that might fail (debug)> update_task_args command="echo hello"
[host1] TASK: Task that might fail (debug)> redo
```
