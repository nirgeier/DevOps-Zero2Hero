![](/resources/images/docker-logo.png)

<!-- omit in toc -->
# Docker Compose Watch

<!-- omit in toc -->
## Table of Contents

- [Introduction](#introduction)
- [Why Use `docker compose watch`](#why-use-docker-compose-watch)
- [Example Usage](#example-usage)
- [Available Actions](#available-actions)
- [How It Works](#how-it-works)
- [Targeting Specific Services or Containers](#targeting-specific-services-or-containers)
- [Preserving State](#preserving-state)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)
- [References](#references)
---

## Introduction

`docker compose watch` is a Docker Compose feature (v2.23+) that automatically syncs files, rebuilds images, or restarts containers when specific files change. It improves development efficiency by reducing the need for manual rebuild and restart steps.


## Why Use `docker compose watch`

Typical development inside Docker often requires:

- Manually rebuilding the image when code changes
- Manually restarting the container
- Manually syncing files into the container

`docker compose watch` automates all of the above, enabling:

- Hot rebuild: Rebuild and restart the container when code changes
- Hot reload: Sync changes live into the container without restarting
- preserves essential container state



## Example Usage

**Project Structure:**

```
project-root/
├── app/
│   └── app.py
├── templates/
├── requirements.txt
└── Dockerfile
```


**Dockerfile:**
```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
CMD ["python", "app/app.py"]
```

**docker-compose.yml:**
```yaml
# docker-compose.yml
services:
  web:
    build: .
    ports:
      - "5000:5000"
    develop:
      watch:
        - path: ./app
          action: rebuild
        - path: ./templates
          action: sync
        - path: ./requirements.txt
          action: rebuild
```

In this example, Docker Compose is watching three different paths and handling each one differently:

- Rebuilding the container for code changes in `./app`
- Syncing template files in `./templates`
- Rebuilding when dependencies change in `./requirements.txt`


## Available Actions

| Action    | Description                                         | Use Case                        |
|-----------|-----------------------------------------------------|----------------------------------|
| `sync`    | Syncs file changes into the running container       | Static files, templates          |
| `rebuild` | Rebuilds the image and restarts the container       | Source code, dependencies        |
| `restart` | Restarts the container without rebuilding the image | Config changes, reload-only      |

## How It Works

1. Start your container as usual:

   ```bash
   docker compose up --build
   ```

2. In a separate terminal, run the watcher:

   ```bash
   docker compose watch
   ```

   Or combine both in one step:

   ```bash
   docker compose up --watch
   ```

3. File changes are detected and the corresponding action (`rebuild`, `sync`, or `restart`) is performed automatically.

## Targeting Specific Services or Containers

You can use the `target` option in the `watch` section to specify which service or container should respond to file changes. This is useful when you have multiple services and want to control which one is affected by a particular file or directory change.


**Example:**

```yaml
services:
  web:
    build: .
    volumes:
      - web-data:/data
    develop:
      watch:
        - path: ./app
          action: rebuild
          target: web
        - path: ./static
          action: sync
          target: web
  worker:
    build: ./worker
    volumes:
      - worker-data:/workerdata
    develop:
      watch:
        - path: ./worker
          action: rebuild
          target: worker
volumes:
  web-data:
  worker-data:
```

In this example, changes in the `./app` or `./static` directories will trigger actions only for the `web` service, while changes in the `./worker` directory will affect only the `worker` service.

**When to use `target`:**

- When multiple services are defined in your `docker-compose.yml` and you want to avoid unnecessary rebuilds or syncs for unrelated services.
- To fine-tune which containers respond to which file changes, improving efficiency and reducing resource usage.




## Preserving State

One of the key benefits of using `docker compose watch` is its ability to preserve essential container state, even as your code and files change during development. This means you can iterate quickly without losing data or breaking your environment.

- Volumes remain mounted and data is not lost during rebuilds.
- Networks and service relationships are maintained.
- Syncs and restarts are non-destructive to the running environment.

This makes it safer and more efficient than manually managing rebuilds or using raw bind mounts.

## Best Practices

- Use `sync` for static files, templates, and assets that do not require a rebuild.
- Use `rebuild` for source code, dependencies, or Dockerfile changes.
- Use `restart` for configuration changes that only need a container reload.
- Combine with volume mounts for persistent data and faster development.
- Keep your `docker-compose.yml` organized and only watch necessary paths to avoid unnecessary rebuilds.

## Troubleshooting

- Ensure you are using Docker Compose v2.23 or newer for watch support.
- Double-check file paths and permissions if changes are not detected.
- Use `docker compose --verbose watch` for detailed logs and debugging.
- If containers do not restart or rebuild, verify your `action` settings in the `watch` section.
- For large projects, limit the number of watched files to improve performance.

## References

- [Docker Compose Watch Documentation](https://docs.docker.com/compose/watch/)
- [Docker Compose File Reference](https://docs.docker.com/compose/compose-file/)
