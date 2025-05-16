# Configuring ssh-agent, Agent Forwarding, and Agent Protocol

The `ssh-agent` is a helper program that manages users' identity keys and their passphrases, implementing a form of single sign-on (SSO). By using `ssh-agent`, users can log into servers securely without repeatedly typing passwords or passphrases.

---

## Contents

1. [Starting ssh-agent](#starting-ssh-agent)
2. [Adding SSH Keys to the Agent](#adding-ssh-keys-to-the-agent)
3. [SSH Agent Forwarding](#ssh-agent-forwarding)
4. [Running ssh-agent](#running-ssh-agent)
5. [Further Reading](#further-reading)

---

## Starting ssh-agent

On most Linux systems, `ssh-agent` is automatically configured and started at login. However, if it is not automatically running, it can be started manually using:

```bash
eval `ssh-agent`
```

The `ssh-agent` command outputs commands to set certain environment variables in the shell. By default, the output commands are compatible with `/bin/sh` and `/bin/bash`. For C-shell (`/bin/csh` or `/bin/tcsh`), use:

```bash
eval `ssh-agent -c`
```

### Checking if ssh-agent is Running

The easiest way to verify if `ssh-agent` is running is to check the value of the `SSH_AGENT_SOCK` environment variable:

```bash
echo $SSH_AGENT_SOCK
```

If the environment variable is set, `ssh-agent` is presumably running.

### Enabling Public Key Authentication

To allow key-based logins, public key authentication must be enabled on the server. In OpenSSH, this is enabled by default and controlled by the `PubkeyAuthentication` option in the `sshd_config` file.

---

## Adding SSH Keys to the Agent

The `ssh-add` command is used to add private keys to the agent:

1. To add default key files (`~/.ssh/id_rsa`, `~/.ssh/id_dsa`, etc.):
   ```bash
   ssh-add
   ```

2. To add a specific private key file:
   ```bash
   ssh-add /path/to/private/key
   ```

3. To list all private keys currently accessible to the agent:
   ```bash
   ssh-add -l
   ```

By default, the agent uses keys stored in the `.ssh` directory under the user's home directory.

---

## SSH Agent Forwarding

Agent forwarding is a mechanism that allows the local `ssh-agent` to be used on remote servers as though it were local to them. This functionality enables single sign-on (SSO) across multiple servers.

### How Agent Forwarding Works

1. An SSH client logs into a remote server.
2. The remote server uses the local `ssh-agent` via forwarding.
3. Any subsequent SSH connections from the remote server will also use the local `ssh-agent`.

This mechanism provides seamless and secure access to servers, regardless of organizational boundaries or geography, including cloud services and external customer premises.

### Enabling Agent Forwarding

1. **On the Client:**
   Set the `ForwardAgent` option to `yes` in the `ssh_config` file:
   ```bash
   ForwardAgent yes
   ```

2. **On the Server:**
   Ensure the `AllowAgentForwarding` option is set to `yes` in the `sshd_config` file:
   ```bash
   AllowAgentForwarding yes
   ```

---

## Running ssh-agent

For detailed options available with `ssh-agent`, refer to the following commands:

- Start `ssh-agent`:
  ```bash
  eval `ssh-agent`
  ```

- Kill the running agent:
  ```bash
  ssh-agent -k
  ```

- Set a time limit for identities in the agent:
  ```bash
  ssh-agent -t 2h
  ```

---

## Further Reading

- OpenSSH Documentation: [https://www.openssh.com/](https://www.openssh.com/)
- SSH Key Management Guidelines
- Secure Shell Best Practices

This site is open source. Improve this page.