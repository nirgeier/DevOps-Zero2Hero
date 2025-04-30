# AUFS – Another Union File System

**AUFS (Another Union File System)** is a special type of filesystem that allows multiple directories (called branches) to be combined into a single unified view. Docker used AUFS in earlier versions as one of its storage drivers to manage image layers.

---
## How Docker Uses AUFS

When a Docker container is started, Docker stacks multiple **read-only layers** (from base images such as `ubuntu` or `mysql`) and adds a **writable layer** on top. This layered structure allows Docker to:

- Reuse common layers across different containers
- Reduce disk usage by avoiding duplication
- Speed up image builds and deployments

If multiple images are based on the same parent image (e.g., Ubuntu), Docker reuses those base layers and only downloads or creates layers that are not already present.

---

## Example: Running a Container

When you run the following command:

```bash
docker run -it ubuntu
```
Docker performs the following steps:

- Checks whether the Ubuntu image layers exist locally.
- If not, downloads them from Docker Hub.
- Stacks them into a read-only filesystem.
- Adds a new AUFS writable layer on top.
- Starts the container.


Next time you will run a different image that shares the same base image :

```bash
docker run -it custom-img
```
Docker will reuse the already downloaded Ubuntu layers, pull and add only the layers specific to custom-img, and create a new writable layer for the container session.
