# SSH Protocol

The SSH protocol (Secure Shell) is a widely used protocol for secure remote access to systems and devices. It provides strong encryption and authentication mechanisms, allowing users to securely log in to remote machines and execute commands or transfer files.

In addition to traditional password authentication, the Secure Shell application can use public key cryptography to authenticate users.

---

## Basic Usage

The basic usage of the `ssh` command is as follows:

```bash
ssh [user@]hostname [command]
```

- `user`: The username to use for the remote connection (optional).
- `hostname`: The hostname or IP address of the remote system.
- `command`: The command to execute on the remote system (optional). If you omit the command, `ssh` will open a shell session on the remote system, allowing you to interact with it as if you were physically sitting in front of it.

Example:

```bash
[myuser@hostname]$ ssh ec2-user@server1
```

The first time connecting to a system, `ssh` will ask you to verify the authenticity of the remote host by displaying the fingerprint of the remote system’s public key. Verified server fingerprints are stored in the client’s machine under `~/.ssh/known_hosts`.

---

### Generating a Public-Private Key Pair Locally

A user’s public-private key pair can be generated with the `ssh-keygen` command:

```bash
[myuser@station myuser]$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/myuser/.ssh/id_rsa): ENTER
Enter passphrase (empty for no passphrase): ENTER
Enter same passphrase again: ENTER
Your identification has been saved in /home/myuser/.ssh/id_rsa.
Your public key has been saved in /home/myuser/.ssh/id_rsa.pub.
```

Important points:
- **Private Key**: Stored in `/home/myuser/.ssh/id_rsa`.
- **Public Key**: Stored in `/home/myuser/.ssh/id_rsa.pub`.
- Never share your private key, even over a secure channel.

---

### Allowing Account Access: `~/.ssh/authorized_keys`

To grant SSH access to a server:
1. Obtain the public key of the user.
2. Append the public key to the server’s `~/.ssh/authorized_keys` file (one public key per line).

The `~/.ssh/authorized_keys` file and the entire `~/.ssh` directory must only be readable by the user.

---

### Transferring Files Securely: `scp`

The `scp` command is used to securely copy files between systems. The syntax is similar to `cp`, but with the addition of remote machine details:

```bash
scp [source] [destination]
```

For a remote file:

```bash
user@host:path
```

Examples:
1. Copy a file from a remote server:
   ```bash
   [myuser@hostname]$ scp ec2-user@server1:/etc/services cfg/server1/etc/
   ```

2. Copy a directory recursively:
   ```bash
   [myuser@hostname]$ scp -r /etc/sysconfig ec2-user@server1:/tmp
   ```

---

## Exercises

### :pencil2: Simple Connection

Use the `ssh` command to connect to your machine.

---

### :pencil2: Port Forwarding

SSH port forwarding allows secure tunneling of traffic between local and remote machines over an encrypted connection.

Task: Connect to the remote server while forwarding port `8087` from the remote machine into port `8085` on the local machine.

---

### :pencil2: Adding New Keys

1. Generate another RSA key pair.
2. Allow SSH connection using the new key pair by appending the public key to the `authorized_keys` file located in the remote machine under `/config/.ssh/`.

---

### Optional Practice

#### Change Fingerprint

1. Stop the Docker container process (e.g., `CTRL+C`).
2. Restart the container and try connecting again. Observe the warning about the changed fingerprint.
3. Fix the warning by updating the `known_hosts` file.

---

#### Password Authentication

While password authentication in SSH is possible, it is not recommended due to vulnerabilities like brute-force attacks. Secure alternatives include using key-based authentication.

Task: Attempt to brute-force a 4-digit password for the user `elvis` using a script:

```bash
for i in $(seq 1000 3000); do
  echo trying $i
  sshpass -p $i ssh -o StrictHostKeyChecking=no -p 2222 elvis@172.17.0.2
done
```

---

#### Change SSH Daemon Configuration

To modify the SSH daemon configuration:
1. Edit the `sshd_config` file (typically in `/etc/ssh/`).
2. Restart the SSH daemon to apply changes.

Task: Configure the SSH daemon to **disable password authentication entirely**. To restart the SSH daemon in a Docker container:

```bash
kill -HUP $(cat /config/sshd.pid)
```

This site is open source. Improve this page.