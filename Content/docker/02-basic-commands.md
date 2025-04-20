<div align="left">
  <img src="/resources/images/docker-logo.png" alt="Docker" >
</div>

<!-- omit in toc -->
# Docker Basic Commands

<!-- omit in toc -->
## Table of Contents

- [1. Introduction](#1-introduction)
- [2. docker run](#2-docker-run)
- [3. docker ps](#3-docker-ps)
- [4. docker stop & docker rm](#4-docker-stop--docker-rm)
- [5. docker images](#5-docker-images)
- [6. docker pull & docker rmi](#6-docker-pull--docker-rmi)
- [7. docker exec & docker logs](#7-docker-exec--docker-logs)
- [8. Docker Command Cheat Sheet](#8-docker-command-cheat-sheet)

---

## 1. Introduction

In this section, we will introduce some of the most commonly used Docker commands. These commands are fundamental for interacting with Docker containers and images, allowing you to manage, monitor, and troubleshoot your Docker environment effectively.

---

## 2. docker run

The `docker run` command is used to create and start a container from a specified image.

### Basic Syntax:
```bash 
docker run [OPTIONS] IMAGE [COMMAND] [ARG...] 
```

#### Example:
```bash 
docker run hello-world 
```

> 💡 **Note**: This will download the `hello-world` image from Docker Hub (if not already present) and run it.

#### Common Options:
- `-d`: Run container in detached mode (in the background).
- `-p`: Map ports between the host and the container (e.g., `-p 8080:80`).
- `--name`: Assign a custom name to the container.

> 💡 **Note**: The `docker run` command automatically pulls the image if it's not already on your local machine.

---

## 3. docker ps

The `docker ps` command lists all the running containers.

### Basic Syntax:
```bash 
docker ps 
```
#### Example Output:

```plaintext
CONTAINER ID   IMAGE           COMMAND                  CREATED        STATUS       PORTS                  NAMES
d9b100f2f636   ubuntu:18.04    "bash"                   5 minutes ago  Up 4 minutes  0.0.0.0:8080->80/tcp   nice_boyd
```

Use the `-a` flag to show all containers, including those that are stopped:
```bash 
docker ps -a 
```

---

## 4. docker stop & docker rm

- `docker stop`: Stops a running container.
- `docker rm`: Removes a container (useful after stopping a container).

### Example:
```bash 
docker stop <container_name_or_id> 
```
```bash 
docker rm <container_name_or_id> 
```

You can combine both commands in one line to stop and remove a container:
```bash 
docker rm -f <container_name_or_id> 
```

---

## 5. docker images

The `docker images` command lists all available images on your system.

### Basic Syntax:
```bash 
docker images 
```

#### Example Output:
 ```plaintext
 REPOSITORY          TAG       IMAGE ID       CREATED         SIZE
 ubuntu              18.04     3b8a3e55e4f3   3 days ago      64.2MB
 hello-world         latest    fce289e99eb9   4 months ago    1.84kB
 ```
---

## 6. docker pull & docker rmi

- `docker pull`: Downloads a Docker image from a registry (e.g., Docker Hub).
  
  ``bash 
  docker pull <image_name> 
  ```

- `docker rmi`: Removes an image from your local system.
  
  ```bash 
  docker rmi <image_name_or_id> 
  ```

> ⚠️ **Caution**: Be sure that the image is not in use by any containers before removing it.

---

## 7. docker exec & docker logs

- `docker exec`: Executes a command inside a running container.

  ### Example:
  ```bash 
  docker exec -it <container_name_or_id> bash 
  ```

  This opens a Bash shell inside the container.

- `docker logs`: Fetches logs from a running container.

  ### Example:
```bash 
docker logs <container_name_or_id> 
```

---

## 8. Docker Command Cheat Sheet

| Command                     | Description                                                  |
|-----------------------------|--------------------------------------------------------------|
| `docker run`                 | Start a container from an image                              |
| `docker ps`                  | List running containers                                      |
| `docker stop <container>`    | Stop a running container                                     |
| `docker rm <container>`      | Remove a container                                           |
| `docker images`              | List local Docker images                                     |
| `docker pull <image>`        | Pull an image from Docker Hub or other registry              |
| `docker rmi <image>`         | Remove a Docker image                                        |
| `docker exec -it <container>`| Run a command inside a running container (interactive mode) |
| `docker logs <container>`    | View logs for a container                                    |

> 💡 **Tip**: Keep this cheat sheet handy when working with Docker to speed up your workflow!

---
