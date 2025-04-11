
---

### 📁 `vault-intro.md`

```markdown
# 🔐 HashiCorp Vault

**HashiCorp Vault** is a powerful open-source tool for securely managing secrets, credentials, and encryption keys in complex infrastructure.

---

## 🚀 Why Use Vault?

- 🔐 Strong encryption for secrets at rest and in transit
- 🔁 Dynamic secrets (e.g., generate DB passwords on the fly)
- 🧾 Audit logs for every access
- 📋 Fine-grained access policies with ACLs
- 🔐 Secret leasing and expiration

---

## 🔧 Basic Terminology

- Secret Engine – Where secrets are stored (e.g., key-value, database)

- Policies – Define access control (who can do what)

- Auth Methods – How users authenticate (e.g., GitHub, LDAP, tokens)


---

## 🧪 Example Use: Key/Value Secrets

### Step 1: Start Dev Server (local)

```bash
vault server -dev
export VAULT_ADDR='http://127.0.0.1:8200'
```

### Step 2: Store and Retrieve Secrets
```bash
vault kv put secret/myapp password="s3cr3t"
vault kv get secret/myapp
```
---

### Dynamic Secrets (PostgreSQL Example)
Vault can generate database credentials dynamically with TTLs.

1. Enable DB engine:

```bash
vault secrets enable database
```
2. Configure PostgreSQL:
```bash
vault write database/config/my-postgresql \
  plugin_name=postgresql-database-plugin \
  connection_url="postgresql://{{username}}:{{password}}@host:5432/dbname" \
  allowed_roles="readonly"
  ```
3. Create a role:

```bash
vault write database/roles/readonly \
  db_name=my-postgresql \
  creation_statements="CREATE ROLE ..." \
  default_ttl="1h" \
  max_ttl="24h"
  ```

### ✅ Best Practices
- Use namespaces and ACL policies for role-based access

- Enable audit devices

- Run Vault in HA mode with Consul for production

- Prefer dynamic secrets over static ones

