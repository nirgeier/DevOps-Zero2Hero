# Local Kubernetes Development with kind

This guide will help you set up a local Kubernetes cluster using kind and deploy a simple Nginx service with a static HTML file.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) installed
- [kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation) installed

## Step 1: Create a kind Cluster

```bash
# Create a new kind cluster
kind create cluster --name dev-cluster

# Verify cluster is running
kubectl cluster-info --context kind-dev-cluster
```

## Step 2: Create Deployment Files

Create a new directory for your Kubernetes manifests:

```bash
mkdir k8s-manifests
cd k8s-manifests
```

### Create nginx-deployment.yaml:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
        volumeMounts:
        - name: html-content
          mountPath: /usr/share/nginx/html
      volumes:
      - name: html-content
        configMap:
          name: nginx-html
```

### Create nginx-service.yaml:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
  - port: 80
    targetPort: 80
  type: LoadBalancer
```

### Create nginx-html-configmap.yaml:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-html
data:
  index.html: |
    <!DOCTYPE html>
    <html>
    <head>
        <title>Welcome to Nginx!</title>
    </head>
    <body>
        <h1>Hello from Nginx running in Kubernetes!</h1>
        <p>This is a static HTML page served by Nginx in a kind cluster.</p>
    </body>
    </html>
```

## Step 3: Deploy the Application

```bash
# Apply all manifests
kubectl apply -f nginx-html-configmap.yaml
kubectl apply -f nginx-deployment.yaml
kubectl apply -f nginx-service.yaml

# Check deployment status
kubectl get deployments
kubectl get pods
kubectl get services
```

## Step 4: Access the Application

Since we're using kind, we need to forward the service port to access it:

```bash
# Forward the service port
kubectl port-forward service/nginx-service 8080:80
```

Now you can access the Nginx service at http://localhost:8080

## Cleanup

To clean up your kind cluster:

```bash
kind delete cluster --name dev-cluster
```

## Troubleshooting

- If you encounter any issues, check the pod logs:
  ```bash
  kubectl logs <pod-name>
  ```
- To describe a pod for more details:
  ```bash
  kubectl describe pod <pod-name>
  ``` 