# 🐳 Dockerfile Use Case and Commands

## 🧠 Use Case

This project uses a `Dockerfile` to containerize an application, allowing us to package the app and its dependencies into a lightweight, portable container image. This ensures consistency across development, testing, and production environments.

Using Docker as part of our DevOps workflow provides several benefits:

- **Isolation**: Each app runs in its own container with its own dependencies.
- **Portability**: Run your app anywhere Docker is supported.
- **Scalability**: Easily scale containers using orchestration tools like Kubernetes.
- **CI/CD Integration**: Containers are easy to build and deploy in automated pipelines.

---

## 🛠️ Dockerfile Commands Overview

Here are the most commonly used Dockerfile instructions used to build our image:

| Command | Description |
|--------|-------------|
| `FROM` | Sets the base image. Example: `FROM node:18-alpine` tells Docker to use Node.js 18 on Alpine Linux as the base image. |
| `WORKDIR` | Sets the working directory inside the container. Example: `WORKDIR /app` ensures all subsequent commands run in `/app`. |
| `COPY` | Copies files from the host machine to the container. Example: `COPY . .` copies all files in the context to the working directory in the container. |
| `RUN` | Executes a command during image build. Example: `RUN npm install` installs dependencies. |
| `EXPOSE` | Documents which port the container will use. Example: `EXPOSE 3000` shows that the app will listen on port 3000. |
| `CMD` | Specifies the default command to run when the container starts. Example: `CMD ["npm", "start"]` runs the app. |
| `ENTRYPOINT` | Sets the main command to run in the container. Unlike `CMD`, this cannot be easily overridden when the container starts. Example: `ENTRYPOINT ["nginx", "-g", "daemon off;"]` ensures NGINX runs as the main process. |

---
## Prerequisites
Before you begin, ensure you have the following installed:
- 🖥️ [Docker for Windows](https://www.docker.com/products/docker-desktop/)
- 🐧 [Docker for Linux](https://docs.docker.com/engine/install/)
- 🔡 Git (for cloning the repo)

---
## 🧪 Example Dockerfile
```Dockerfile
# Use the official NGINX image
FROM nginx:alpine

# Expose port 80
EXPOSE 80

# NGINX is started by default, so no need to override CMD
```

```

## 🚀 How to Build and Run

### Copy the Dockerfile example above to a file named "Dockerfile" (make sure you have Docker runing on your computer)

### Build the Docker Image

```bash
docker build -t my-nginx .
```

### Run the Container

```bash
docker run -d -p 8080:80 my-nginx
```
Now visit [http://localhost:8080](http://localhost:8080) in your browser — you should see the default NGINX welcome page.
---
### Debug container issue
```bash
docker ps
```

🛑 Entry to docker container by name or by id
```bash
docker exec -it <container_name_or_id> /bin/bash
```

🛑 Checking logs from container 
```bash
docker logs <container_name_or_id>
```


### Stop the Container

🛑 Stop the Container
```bash
docker ps
```
Find the CONTAINER ID or name from the output, then:
```bash
docker stop <container_id_or_name>
```
---

## ✅ Summary

This Dockerfile allows us to build a consistent and repeatable container image for our application. By following best practices in Dockerfile construction, we ensure smaller image sizes, faster builds, and better security.

