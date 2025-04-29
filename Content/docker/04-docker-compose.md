<div align="left">
    <img src="/resources/images/docker-logo.png" alt="Docker Compose" >
</div>

<!-- omit in toc -->
# Docker Compose

<!-- omit in toc -->
## Table of Contents

- [1. Introduction](#1-introduction)
- [2. What is Docker Compose?](#2-what-is-docker-compose)
- [3. docker-compose.yml Structure](#3-docker-composeyml-structure)
- [4. Common Commands](#4-common-commands)
- [5. Extended Command Reference](#5-extended-command-reference)
- [6. Benefits of Docker Compose](#6-benefits-of-docker-compose)

---

## 1. Introduction

Docker Compose is a tool that helps you define and run multi-container Docker applications using a YAML file. You can manage your entire application stack — web app, database, cache, and more — with a single command.

---

## 2. What is Docker Compose?

- **Docker Compose** is a tool for defining and managing multi-container Docker applications.
- The configuration is written in a `docker-compose.yml` file using YAML syntax.
- It simplifies managing services, networks, volumes, and build configurations.
- Designed to support complex environments such as development stacks, test suites, and CI/CD pipelines.

### Key Features

- Start and stop all components together
- Build and push Docker images
- Share data using volumes
- Use environment variables and secrets
- Ensure consistency across local and remote environments

### Common Use Cases

- Local development environments (e.g., apps with web servers, databases).
- Automated testing and CI/CD pipelines.
- Single-command setups for complex services.
- Replicating production environments locally.

---

## 3. docker-compose.yml Structure

Here’s a breakdown of the core elements in a Compose file:

```yaml
version: '3'
services:
    web:
        build: .
        ports:
            - "5000:5000"
        volumes:
            - .:/code
        depends_on:
            - redis

    redis:
        image: redis
```

### Key Sections

- **version**: Defines the Compose file format version.
- **services**: Defines your app's services (containers).
- **build**: Tells Docker to build the image from a Dockerfile.
- **image**: Use a prebuilt image (e.g., from Docker Hub).
- **ports**: Maps container ports to host.
- **volumes**: Mounts code or data directories.
- **depends_on**: Ensures Redis starts before the app.

---

## 4. Common Commands

### Start Services

- Use the `docker compose up` command to create and start all the services defined in the `docker-compose.yml` file.

```bash
docker compose up
```

### Run in Detached Mode

```bash
docker compose up -d
```

### Stop Services

```bash
docker compose down
```

### View Logs

```bash
docker compose logs
```

### Rebuild Services

```bash
docker compose build
```

### Execute Command in Running Container

```bash
docker compose exec <service> <command>
```

Example:

```bash
docker compose exec web bash
```

---

## 5. Extended Command Reference

| **Command**                            | **Description**                                                                                  |
|----------------------------------------|--------------------------------------------------------------------------------------------------|
| `docker compose up`                    | Creates and starts containers, networks, and volumes. Use `-d` for detached mode.                |
| `docker compose down`                  | Stops and removes containers, networks, volumes, and images (`--rmi all` to remove images too). |
| `docker compose build`                 | Builds or rebuilds images.                                                                      |
| `docker compose logs`                  | Displays logs from services. Use `-f` to follow.                                                 |
| `docker compose ps`                    | Lists running containers.                                                                       |
| `docker compose start`                 | Starts existing stopped containers.                                                             |
| `docker compose stop`                  | Stops running containers without removing them.                                                 |
| `docker compose exec <service> <cmd>`  | Runs a command in a running container.                                                          |
| `docker compose pull`                  | Pulls the latest images from a registry.                                                        |
| `docker compose config`                | Validates and shows resolved configuration.                                                     |
| `docker compose pause`                 | Pauses services.                                                                                |
| `docker compose unpause`              | Resumes paused services.                                                                        |
| `docker compose restart`              | Restarts services.                                                                              |
| `docker compose top`                  | Shows processes in containers.                                                                  |
| `docker compose run <service> <cmd>`   | Runs a one-off command in a new container.                                                      |

---

## 6. Benefits of Docker Compose

- **Simplicity**: Manage everything in one config file.
- **Automation**: Build, start, test, stop — all with one command.
- **Isolation**: Keep app environments separate and clean.
- **Repeatability**: Replicate full stacks reliably in any environment.
- **Networking**: Built-in DNS-based service discovery.

---
