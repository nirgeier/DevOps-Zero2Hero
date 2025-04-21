<div align="left">
    <img src="/resources/images/docker-logo.png" alt="Docker" >
</div>

<!-- omit in toc -->
# Dockerfile

## Table of Contents

- [1. Introduction](#1-introduction)
- [2. Dockerfile Syntax](#2-dockerfile-syntax)
- [3. Basic Dockerfile Instructions](#3-basic-dockerfile-instructions)
- [4. Building an Image](#4-building-an-image)
- [5. Multi-stage Builds](#5-multi-stage-builds)
- [6. Best Practices for Writing Dockerfiles](#6-best-practices-for-writing-dockerfiles)
- [7. Example: Dockerizing a Python App](#7-example-dockerizing-a-python-app)

---

## 1. Introduction

A **Dockerfile** is a script containing a series of instructions on how to build a Docker image. These instructions are executed in order to set up the environment and application inside the container.

---

## 2. Dockerfile Syntax

A Dockerfile consists of various instructions, each performing a specific task. Each instruction creates a new layer in the Docker image.

> 💡**Note:** Layers are cached by Docker, which can speed up subsequent builds if the layers remain unchanged. However, excessive or unnecessary layers can increase the image size, so it's important to write efficient Dockerfiles.

### Common Instructions:
- **FROM**: Specifies the base image to use.
- **RUN**: Executes commands in the image.
- **COPY**: Copies files from the host to the container.
- **CMD**: Specifies the default command to run when a container is started.
- **ENTRYPOINT**: Defines a command that will always run when the container starts.
- **WORKDIR**: Sets the working directory for any subsequent commands.

---

## 3. Basic Dockerfile Instructions

### FROM

```bash
FROM <image>
```

- The `FROM` instruction specifies the base image to use for the container. It is mandatory and must be the first instruction in a Dockerfile.

    ### Example:
    ```Dockerfile
    FROM ubuntu:20.04
    ```

### RUN
```bash
RUN <command>
```
- The `RUN` instruction executes commands in a new layer on top of the current image. To reduce the number of layers, you can combine multiple commands using `&&`.

    ### Example:
    ```Dockerfile
    RUN apt-get update && apt-get install -y python3 python3-pip
    ```

### COPY
```bash
COPY <source> <destination>
```
- The `COPY` instruction copies files from your host machine into the Docker image.
- Unlike `ADD`, `COPY` is more straightforward and does not support features like extracting tar files or downloading files from URLs. Use `COPY` when you only need to copy files and directories.

    ### Example:
    ```Dockerfile
    COPY . /app
    ```
    This copies the entire current directory to the `/app` folder inside the container.

### CMD
```bash
CMD ["executable", "param1", "param2"]
```
- The `CMD` instruction specifies the default command to run when the container is started. It can be overridden by arguments passed to the `docker run` command.

    ### Example:
    ```Dockerfile
    CMD ["python3", "app.py"]
    ```

---

## 4. Building an Image

Once you’ve written your Dockerfile, you can build the image using the `docker build` command.

### Syntax:
```bash
docker build -t <image_name> .
```

### Example:
```bash
docker build -t my-python-app .
```

This will build a Docker image from the Dockerfile in the current directory.

---

## 5. Multi-stage Builds

Multi-stage builds allow you to create smaller, more efficient images by separating the build and runtime environments. This approach reduces the final image size by excluding unnecessary build tools and dependencies, and it improves security by minimizing the attack surface in the runtime image.

### Example:

```Dockerfile
# Stage 1: Build the app
FROM node:14 AS build-stage
WORKDIR /app
COPY . .
RUN npm install

# Stage 2: Run the app
FROM node:14-slim AS runtime-stage
WORKDIR /app
COPY --from=build-stage /app .
CMD ["npm", "start"]
```
