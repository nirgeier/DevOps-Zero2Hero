
---

### 📁 `k8s-secrets.md`

```markdown
# 🔐 Kubernetes Secrets

Kubernetes provides a native way to manage sensitive data through **Secrets**, allowing you to store credentials, tokens, and keys securely within the cluster.

---

## ⚙️ What Is a Secret in Kubernetes?

A **Secret** is a Kubernetes object that stores sensitive information in key/value pairs.  
They can be mounted into Pods as environment variables or volumes.

> ⚠️ Secrets are **base64-encoded**, not encrypted by default. Enable encryption at rest!

---

## 🧪 Creating a Secret

### Method 1: Imperative (CLI)

```bash
kubectl create secret generic db-credentials \
  --from-literal=username=admin \
  --from-literal=password=secret123
  ```
### Method 2: Declarative (YAML)
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: db-credentials
type: Opaque
data:
  username: YWRtaW4=       # base64 encoded
  password: c2VjcmV0MTIz
  ```
### Using Secrets in a Pod
```yaml

env:
  - name: DB_USER
    valueFrom:
      secretKeyRef:
        name: db-credentials
        key: username
```
Or mount as file:

```yaml

volumeMounts:
  - name: secret-volume
    mountPath: "/etc/secrets"
volumes:
  - name: secret-volume
    secret:
      secretName: db-credentials
```
🔒 Encrypt Secrets at Rest (Recommended)
Edit the EncryptionConfiguration in kube-api server and enable KMS provider or AES encryption for secrets.

✅ Best Practices
- Always enable encryption at rest for secrets

- Avoid exposing secrets to containers unnecessarily

- Use RBAC to control secret access

- Rotate secrets regularly

- Consider tools like:

- Sealed Secrets (Bitnami)

- External Secrets Operator

- Vault Kubernetes Injector


