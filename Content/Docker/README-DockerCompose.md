# Docker Compose Overview

---

- [Docker Compose Overview](#docker-compose-overview)
    - [Docker Compose](#docker-compose)
    - [Docker Compose Commands](#docker-compose-commands)

---

### Docker Compose 

- **Docker Compose** is a tool for defining and managing multi-container Docker applications. 
- **Docker Compose** is written as YAML file named `docker-compose.yaml` 
- **Docker Compose** is designed for configure services, networks,  volumes and more.
- **Docker Compose** is a powerful tool for managing complex applications
- **Docker Compose** supports various features such as: 
  - Start all components
  - Build docker images
  - Push docker images
  - Share volumes
  - Support for environment variables, secrets, and more.
- **Docker Compose** simplifies workflows in development, testing, and deployment by ensuring consistency across different environments.

**Common Use Cases**:

- Local development environments (e.g., apps with web servers, databases).
- Automated testing and CI/CD pipelines.
- Single-command setups for complex services.
- Replicating production environments locally.

---

### Docker Compose Commands

| **Command**                           | **Description**                                                                                 |
| ------------------------------------- | ----------------------------------------------------------------------------------------------- |
| `docker compose up`                   | Creates and starts containers, networks, and volumes. Use `-d` for detached mode.               |
| `docker compose down`                 | Stops and removes containers, networks, volumes, and images (use `--rmi all` to remove images). |
| `docker compose build`                | Builds or rebuilds images defined in the `docker-compose.yml` file.                             |
| `docker compose logs`                 | Displays logs from services (use `-f` to follow logs).                                          |
| `docker compose ps`                   | Lists running containers associated with the compose file.                                      |
| `docker compose start`                | Starts existing stopped containers.                                                             |
| `docker compose stop`                 | Stops running containers without removing them.                                                 |
| `docker compose exec <service> <cmd>` | Executes a command in a running container (e.g., `docker compose exec app bash`).               |
| `docker compose pull`                 | Downloads the latest images for services defined in the compose file.                           |
| `docker compose config`               | Validates and displays the resolved compose configuration.                                      |
| `docker compose pause`                | Pauses all or specified containers.                                                             |
| `docker compose unpause`              | Resumes paused containers.                                                                      |
| `docker compose restart`              | Restarts containers (all or specified services).                                                |
| `docker compose top`                  | Shows running processes in containers.                                                          |
| `docker compose run <service> <cmd>`  | Runs a one-off command in a new container (e.g., `docker compose run app pytest`).              |

---

**Example Workflow**:
1. Define services in `docker-compose.yml`.
2. Run `docker compose build` to build images.
3. Start with `docker compose up -d`.
4. View logs with `docker compose logs -f`.
5. Stop and clean up with `docker compose down`.