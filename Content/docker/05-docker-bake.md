<div align="left">
  <img src="/resources/images/docker-logo.png" alt="Docker" >
</div>

<!-- omit in toc -->
# Docker Bake

<!-- omit in toc -->
## Table of Contents

- [1. Introduction](#1-introduction)
- [2. Docker Bake vs Traditional Docker Build](#2-docker-bake-vs-traditional-docker-build)
- [3. docker-bake.hcl Structure](#3-docker-bakehcl-structure)
- [4. Common Commands](#4-common-commands)
- [5. Advanced Features](#5-advanced-features)
- [6. Benefits of Docker Bake](#6-benefits-of-docker-bake)

---

## 1. Introduction

- **Docker Bake** is a high-level build tool that uses BuildKit to build Docker images defined in configuration files.
- It extends beyond single Dockerfiles to support complex build scenarios with multiple targets, platforms, and configurations.
- A configuration file is written in `docker-bake.hcl` (HashiCorp Configuration Language) or `docker-bake.json` formats.
- Designed for CI/CD pipelines, multi-platform builds, and complex build workflows.

> 💡 **BuildKit**: A backend engine that builds Docker images, replacing the traditional docker build mechanism.

### Key Features

- **Multi-platform builds**: Build for multiple architectures simultaneously (ARM, AMD64, etc.)
- **Build matrix**: Define multiple build configurations and targets
- **Advanced caching**: Sophisticated caching strategies for faster builds
- **Inheritance**: Reuse common configurations across multiple targets
- **Variable interpolation**: Use variables and functions for dynamic configurations

---

## 2. Docker Bake vs Traditional Docker Build

While both approaches build Docker images, they serve different scales of complexity:

| Feature | Traditional Docker Build | Docker Bake |
|---------|-------------------------|-------------|
| **Command** | `docker build` | `docker buildx bake` |
| **Configuration** | Command-line flags | Configuration files (HCL/JSON) |
| **Multi-platform** | One at a time | Simultaneous multi-arch builds |
| **Build Matrix** | No | Yes |
| **Caching** | Basic | Advanced BuildKit caching |
| **Multiple Targets** | Manual commands | Single command |

> 💡 **BuildKit Required**: Docker Bake requires BuildKit backend for advanced build features.

---

## 3. docker-bake.hcl Structure

Here's a basic `docker-bake.hcl` file structure:

```hcl
# Define variables
variable "TAG" {
  default = "latest"
}

variable "USER" {
  default = "username"
}

# Define a group of targets for an oline shop application
group "default" {
  targets = ["frontend", "backend-api"]
}

# React/Vite frontend service
target "frontend" {
  context    = "./shop-frontend" // Directory containing the frontend code
  dockerfile = "Dockerfile.prod" // Use a specific Dockerfile for production
  tags       = ["${USER}/shop-frontend:${TAG}"]
  platforms = ["linux/amd64", "linux/arm64"]
  args = {
    // Pass build-time variables to the Dockerfile (e.g., for Vite)
    VITE_API_URL = "https://api.shop.com"
  }
}

# Node.js backend service
target "backend-api" {
  context    = "./shop-backend" // Directory for the backend API
  dockerfile = "Dockerfile"
  tags       = ["${USER}/shop-backend:${TAG}"]
  platforms  = ["linux/amd64", "linux/arm64"]
  args = {
    // Set Node.js environment to production
    NODE_ENV = "production"
  }
}
```

### Key Sections

- **variable**: Define reusable variables
- **group**: Group multiple targets together
- **target**: Define individual build configurations
- **context**: Build context directory
- **dockerfile**: Path to Dockerfile
- **tags**: Image tags to apply
- **platforms**: Target platforms for multi-arch builds
- **args**: Build arguments

---

## 4. Common Commands

### Build Default Group

```bash
docker buildx bake
```

### Build Specific Target

```bash
docker buildx bake web
```

### Build with Custom Variables

```bash
docker buildx bake --set *.tags=myapp:v1.0.0
```

### Build and Push

```bash
docker buildx bake --push
```

### Build for Specific Platform

```bash
docker buildx bake --platform linux/arm64
```

### View Build Configuration

```bash
docker buildx bake --print
```

### Build with Custom File

```bash
docker buildx bake -f custom-bake.hcl
```

---

## 5. Advanced Features

### Multi-Stage Builds with Matrix

**What is a Build Matrix?**
A build matrix allows you to create multiple image variations from a single configuration. Instead of writing separate targets for each combination, Docker Bake automatically generates all possible combinations.

**Example:** Building multiple Node.js versions for different environments

```hcl
target "app" {
  matrix = {
    version = ["18", "20"]
    env = ["dev", "prod"]
  }
  
  name = "app-node${version}-${env}"
  context = "."
  dockerfile = "Dockerfile"
  tags = ["myapp:node${version}-${env}"]
  
  args = {
    NODE_VERSION = version
    NODE_ENV = env
  }
}
```

**What this creates:**
- `app-node18-dev` - Node.js 18 for development
- `app-node18-prod` - Node.js 18 for production  
- `app-node20-dev` - Node.js 20 for development
- `app-node20-prod` - Node.js 20 for production

> 💡 **Use Case**: Perfect for testing your app across different versions or environments without manually creating each build target.

---

### Build Secrets

**What are Build Secrets?**
Build secrets allow you to securely pass sensitive information (like API keys, passwords, or certificates) to your Docker build process without including them in the final image or build history.

**Example:** Using a secret file during build

```hcl
target "secure-app" {
  context = "."
  dockerfile = "Dockerfile"
  secret = [
    "id=mysecret,src=./secret.txt"
  ]
  tags = ["myapp:secure"]
}
```

**In your Dockerfile:**
```dockerfile
FROM node:18

# Use the secret during build (it won't be in the final image)
RUN --mount=type=secret,id=mysecret \
    API_KEY=$(cat /run/secrets/mysecret) && \
    npm install --registry=https://registry.example.com
```

> 💡 **Security**: The secret is only available during the build process and never stored in the final image layers.

> **--mount=type=secret**: This tells Docker to mount a secret file into the build environment. This mount is temporary and only exists for this single RUN command. It will not be part of any image layer

---

### Cache Configuration

**What is Build Caching?**
Build caching stores parts of your build process so future builds can reuse previously built layers, making subsequent builds much faster.

**Example:** Using GitHub Actions cache

```hcl
target "cached-app" {
  context = "."
  dockerfile = "Dockerfile"
  cache-from = ["type=gha"]
  cache-to = ["type=gha,mode=max"]
  tags = ["myapp:cached"]
}
```

**Cache Types:**

- `type=gha` - GitHub Actions cache (for CI/CD)
- `type=local` - Local filesystem cache
- `type=registry` - Docker registry cache

**How it works:**

1. **First build**: Takes full time, saves cache
2. **Second build**: Reuses cached layers, builds only changed parts
3. **Result**: Significantly faster build times

> 💡 **Speed Boost**: Can reduce build times from minutes to seconds for unchanged code.

### Inheritance

**What is Target Inheritance?**
Inheritance allows you to create a base configuration and reuse it across multiple targets. This follows the DRY (Don't Repeat Yourself) principle - define common settings once and inherit them.

**Example:** Sharing common settings across multiple builds

```hcl
target "base" {
  context = "."
  dockerfile = "Dockerfile"
  platforms = ["linux/amd64", "linux/arm64"]
}

target "web" {
  inherits = ["base"]
  tags = ["myapp/web:latest"]
  target = "web"
}

target "api" {
  inherits = ["base"]
  tags = ["myapp/api:latest"]
  target = "api"
}
```

**How it works:**

- **Base target**: Defines common settings (context, dockerfile, platforms)
- **Child targets**: Inherit from base and add their specific settings
- **Result**: Both `web` and `api` targets automatically get the same platforms and build context

**Benefits:**

- **Consistency**: All targets use the same base configuration
- **Maintainability**: Change platforms in one place, affects all children
- **Cleaner code**: No repetitive configuration

> 💡 **Think of it like**: Programming class inheritance - children get parent properties.

---

## 6. Benefits of Docker Bake

- **Scalability**: Handle complex build scenarios with multiple targets and platforms
- **Efficiency**: Advanced caching and parallel builds reduce build times
- **Consistency**: Standardized build configurations across environments
- **Flexibility**: Variable interpolation and inheritance for DRY configurations
- **CI/CD Ready**: Perfect for automated build pipelines
- **Multi-platform**: Native support for building across different architectures

---
