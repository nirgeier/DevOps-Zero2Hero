<div align="left">
  <img src="/resources/images/docker-logo.png" alt="Docker" >
</div>

<!-- omit in toc -->
# Docker Introduction

<!-- omit in toc -->
## Table of Contents

- [1. Introduction](#1-introduction)
- [2. What is Containerization?](#2-what-is-containerization)
- [3. What is Docker?](#3-what-is-docker)
- [4. Benefits of Docker](#4-benefits-of-docker)
- [5. Virtual Machines vs Containers](#5-virtual-machines-vs-containers)
- [6. Use Cases in DevOps](#6-use-cases-in-devops)
- [7. Docker Architecture](#7-docker-architecture)

---

## 1. Introduction

- This guide will help you get started with Docker from scratch.  
- Docker is a powerful containerization platform used by developers and DevOps engineers to build, ship, and run applications reliably and consistently across different environments.  
- It provides a lightweight way to package applications with their dependencies, making deployment fast and predictable.

---

## 2. What is Containerization?

Containerization is a technology that allows you to package and run applications and their dependencies in isolated user spaces — called **containers** — on the same operating system.

### Key Concepts:

- A container includes the application code, runtime, system tools, libraries, and settings — everything needed to run the app.
- Containers share the same OS kernel, making them lightweight and fast to start compared to traditional virtual machines.
- Containerized apps are portable and can run anywhere: locally, on a server, or in the cloud.

> 💡 **Think of a container as a lightweight, standalone package that works the same on any system.**

---

## 3. What is Docker?

Docker is an open-source platform that enables developers to automate the deployment of applications inside lightweight, portable containers. These containers include everything the application needs to run — code, runtime, libraries, and system tools — ensuring consistency across environments.

---

## 4. Benefits of Docker

- **Portability**: Containers can run on any system with Docker installed.
- **Efficiency**: Lightweight containers use fewer resources than virtual machines.
- **Isolation**: Applications run in separate containers without interfering with each other.
- **Version Control**: Easily manage and version your application environments.
- **Speed**: Faster boot times and deployments.
- **Scalability**: Works well with microservices and cloud-native architectures.

---

## 5. Virtual Machines vs Containers

| Feature              | Virtual Machines            | Containers                  |
|----------------------|-----------------------------|-----------------------------|
| OS                  | Full guest OS               | Shares host OS             |
| Boot Time           | Minutes                     | Seconds                     |
| Resource Usage      | Heavy (uses more resources) | Lightweight                 |
| Portability         | Less portable               | Highly portable             |
| Use Case            | Monolithic apps             | Microservices, DevOps       |

> 💡 **Key Point**: Containers are faster, lighter, and more scalable than traditional VMs.

---

## 6. Use Cases in DevOps

- **CI/CD Pipelines**: Build and test applications in isolated environments.
- **Microservices**: Run individual services in separate containers.
- **Testing**: Create reproducible test environments.
- **Cloud Deployment**: Use containers to deploy to any cloud provider.

---

## 7. Docker Architecture

Docker uses a client-server architecture:

- **Docker Client**: The command-line tool `docker` that users interact with.
- **Docker Daemon**: Runs in the background and manages containers.
- **Docker Images**: Blueprints for containers (read-only).
- **Docker Containers**: Running instances of images.
- **Docker Registry**: Central place to store and share Docker images (e.g., Docker Hub).

```mermaid
graph TD
    A[Docker Client] -->|Sends Commands| B[Docker Daemon]
    B --> C[Build Image]
    B --> D[Run Container]
    B --> E[Push/Pull from Registry]
    E -->|Public or Private| F[Docker Hub / Registry]
