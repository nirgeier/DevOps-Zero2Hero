# Kubernetes Deployment Manifest Guide

This guide explains the structure and components of a Kubernetes Deployment manifest.

## Basic Deployment Structure

A Kubernetes Deployment manifest is a YAML file that describes the desired state of your application. Here's a breakdown of the key components:


## Key Components Explained

### 1. Metadata Section
- `apiVersion`: Specifies the API version (apps/v1 for Deployments)
- `kind`: Defines the resource type (Deployment)
- `metadata`: Contains identifying information
  - `name`: Unique name for the deployment
  - `labels`: Key-value pairs for resource identification

### 2. Spec Section
- `replicas`: Number of pod instances to maintain
- `selector`: Defines how the deployment finds pods to manage
  - `matchLabels`: Labels that pods must have to be managed by this deployment

### 3. Template Section
- `template`: Defines the pod template
  - `metadata`: Labels for the pod
  - `spec`: Container specifications
    - `containers`: List of containers in the pod
      - `name`: Container name
      - `image`: Container image to use
      - `ports`: Container ports to expose
      - `volumeMounts`: Mount points for volumes
    - `volumes`: Storage volumes available to containers

## Common Fields to Add

### Resource Limits
```yaml
resources:
  limits:
    cpu: "500m"
    memory: "512Mi"
  requests:
    cpu: "100m"
    memory: "128Mi"
```

### Environment Variables
```yaml
env:
- name: ENV_VAR_NAME
  value: "value"
```

### Health Checks
```yaml
livenessProbe:
  httpGet:
    path: /
    port: 80
  initialDelaySeconds: 30
  periodSeconds: 10
```

## Best Practices

1. Always specify resource limits and requests
2. Use meaningful labels for better resource management
3. Implement health checks (liveness and readiness probes)
4. Use ConfigMaps or Secrets for configuration
5. Consider using resource quotas in multi-tenant environments
6. Implement proper security contexts
7. Use imagePullPolicy: Always for production deployments

## Common Commands

```bash
# Apply deployment
kubectl apply -f deployment.yaml

# Check deployment status
kubectl get deployments

# View deployment details
kubectl describe deployment <deployment-name>

# View pod status
kubectl get pods

# View deployment logs
kubectl logs deployment/<deployment-name>

# Scale deployment
kubectl scale deployment <deployment-name> --replicas=3

# Update deployment
kubectl set image deployment/<deployment-name> nginx=nginx:1.19
``` 