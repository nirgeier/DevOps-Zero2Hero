
<img src="../../resources/images/logos/logos_argocd.svg" width="75" height="75" alt="ArgoCD Logo" />

# ArgoCD Lab

Welcome to the **ArgoCD  Deployment Lab**! 🚀  
In this lab, you'll learn how to deploy a simple web application using **ArgoCD**, **GitOps** principles, and **Kubernetes**. 

By the end of this lab, you'll have set up a basic GitOps workflow where a Git repository is the source of truth for your deployment, and ArgoCD handles the deployment automatically to your live Kubernetes cluster.

## Prerequisites

Before you begin, make sure you have the following installed:

- 🖥️ **Kubernetes Cluster** (e.g., [Minikube](https://minikube.sigs.k8s.io/), [Kind](https://kind.sigs.k8s.io/), or any Kubernetes environment)
- ⚡ **kubectl** (command-line tool for Kubernetes)
- 🎯 **ArgoCD CLI** (optional but highly recommended)
- 🔡 **Git** (to clone and push code)

## 📁 Project Structure

### This project is organized as follows:

```bash
argocd-lab/
├── app/                        ← Your web app manifests
│   ├── deployment.yaml         ← Kubernetes Deployment for the app
│   └── service.yaml            ← Kubernetes Service for the app
├── argocd/                     ← ArgoCD-specific configurations
│   └── application.yaml        ← ArgoCD Application manifest
└── README.md                   ← Project instructions       
```



## 🚀 Quick Start
### 1. Install ArgoCD on your cluster:

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

### 2. Port forward ArgoCD UI:
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Visit: http://localhost:8080

### 3. Login to ArgoCD:
```bash
argocd login localhost:8080 --username admin --password <initial_password>
```
### 4. Apply the ArgoCD Application manifest:
```bash
kubectl apply -f argocd/application.yaml
```

### Watch your app get deployed automatically!