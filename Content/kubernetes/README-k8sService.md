# Kubernetes Service Manifest Guide

This guide explains the structure and components of a Kubernetes Service manifest.

## Basic Service Structure

A Kubernetes Service manifest is a YAML file that defines how to expose your application. Here's a breakdown of the key components:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
  labels:
    app: nginx
spec:
  type: LoadBalancer
  ports:
  - port: 80
    targetPort: 80
    protocol: TCP
    name: http
  selector:
    app: nginx
```

## Key Components Explained

### 1. Metadata Section
- `apiVersion`: v1 (for Services)
- `kind`: Service
- `metadata`: Service identification
  - `name`: Unique name for the service
  - `labels`: Key-value pairs for service identification

### 2. Spec Section
- `type`: Service type (ClusterIP, NodePort, LoadBalancer, or ExternalName)
- `ports`: List of ports to expose
  - `port`: Port exposed by the service
  - `targetPort`: Port on the pod to forward to
  - `protocol`: TCP, UDP, or SCTP
  - `name`: Optional name for the port
- `selector`: Labels to match pods for routing traffic

## Service Types

### 1. ClusterIP (Default)
```yaml
spec:
  type: ClusterIP
  ports:
  - port: 80
    targetPort: 80
```
- Only accessible within the cluster
- Internal IP address assigned

### 2. NodePort
```yaml
spec:
  type: NodePort
  ports:
  - port: 80
    targetPort: 80
    nodePort: 30007
```
- Exposes service on each node's IP
- Accessible from outside the cluster
- Port range: 30000-32767

### 3. LoadBalancer
```yaml
spec:
  type: LoadBalancer
  ports:
  - port: 80
    targetPort: 80
```
- Exposes service externally using cloud provider's load balancer
- Automatically creates NodePort and ClusterIP

### 4. ExternalName
```yaml
spec:
  type: ExternalName
  externalName: my.database.example.com
```
- Maps service to external DNS name
- No selectors or ports needed

## Advanced Configurations

### Session Affinity
```yaml
spec:
  sessionAffinity: ClientIP
  sessionAffinityConfig:
    clientIP:
      timeoutSeconds: 3600
```

### Multiple Ports
```yaml
spec:
  ports:
  - name: http
    port: 80
    targetPort: 80
  - name: https
    port: 443
    targetPort: 443
```

### External IPs
```yaml
spec:
  externalIPs:
  - 192.168.1.100
```

## Best Practices

1. Use meaningful service names and labels
2. Choose appropriate service type based on access requirements
3. Use named ports for better readability
4. Implement proper network policies
5. Consider using Ingress for HTTP/HTTPS traffic
6. Use annotations for cloud provider specific configurations
7. Implement proper security contexts

## Common Commands

```bash
# Apply service
kubectl apply -f service.yaml

# Check service status
kubectl get services

# View service details
kubectl describe service <service-name>

# Get service endpoints
kubectl get endpoints <service-name>

# Expose deployment as service
kubectl expose deployment <deployment-name> --port=80 --target-port=80

# Port forward to service
kubectl port-forward service/<service-name> 8080:80
```

## Troubleshooting

1. Check service endpoints:
```bash
kubectl get endpoints <service-name>
```

2. Verify service selector matches pod labels:
```bash
kubectl get pods --show-labels
```

3. Check service events:
```bash
kubectl describe service <service-name>
```

4. Test service connectivity:
```bash
kubectl run test --image=busybox --rm -it -- wget -O- <service-name>:<port>
``` 