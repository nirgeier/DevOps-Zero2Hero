<!-- omit in toc -->
<div align="center">
  <img src="/resources/images/logos/logos_github_actions.svg" alt="DevOps-Zero2Hero" width="100" style="border-radius: 25%;padd">
</div>

---

# 1. 📦 Containerized App CI/CD

## 1.1 Table of Content

- [1. 📦 Containerized App CI/CD](#1--containerized-app-cicd)
  - [1.1 Table of Content](#11-table-of-content)
  - [1.2 ℹ️ Introduction](#12-ℹ️-introduction)
  - [1.3 🛠️ Key Concepts](#13-️-key-concepts)
    - [1.3.1 ⚙️ Example Workflow](#131-️-example-workflow)
  - [1.4 🚢 Deployment Targets](#14--deployment-targets)
  - [1.5 💡 Tips](#15--tips)
  - [1.6 🔚 Summary](#16--summary)


---

## 1.2 ℹ️ Introduction

- **GitHub Actions** can automate your entire container lifecycle — from building images to deploying them to cloud registries or Kubernetes clusters.
- This workflow is essential for modern DevOps pipelines.

---

## 1.3 🛠️ Key Concepts

- **Docker Build:** Automate the process of building container images from a Dockerfile.
- **Push to Registry:** Use Actions to log in and push images to registries like DockerHub or Amazon ECR.
- **Tagging:** Use Git metadata to tag images with latest, commit SHA, or release version.
- **Deployments:** Trigger deployment to Kubernetes, ECS, or other platforms using kubectl, Helm, or custom scripts.

---

### 1.3.1 ⚙️ Example Workflow

```yaml
name: CI/CD for Containerized App

on:
  push:
    branches: [main]

jobs:
  build-and-push:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Log in to DockerHub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}

      - name: Build and push Docker image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: your-dockerhub-username/app-name:latest
```

---

## 1.4 🚢 Deployment Targets

| Platform    | Authentication Required        | Recommended Action                                             |
|-------------|--------------------------------|----------------------------------------------------------------|
| DockerHub   | Username & token               | `docker/login-action`, `build-push-action`                     |
| Amazon ECR  | AWS credentials (OIDC or secrets) | `amazon-ecr-login-action` + `build-push-action`             |
| Kubernetes  | `kubectl`, `kubeconfig`        | `azure/setup-kubectl`, or manual scripts                      |

---

## 1.5 💡 Tips
- Use **secrets** for registry credentials.
- Use **multi-stage Dockerfiles** for smaller, secure images.
- Use **commit SHA** or **Git tags** to version images for traceability.
- Optionally include a **post-deployment test** step to verify app health.

---

## 1.6 🔚 Summary
- Automate Docker builds with GitHub Actions.
- Push to DockerHub or cloud registries securely.
- Deploy to Kubernetes or ECS with minimal config.
- Keep builds traceable with tags and commit SHAs.
- Use secrets and follow container security best practices.