# 🔐 AWS Secrets Manager

**AWS Secrets Manager** is a fully managed service for storing and retrieving sensitive information such as:

- API keys
- Database credentials
- Cloud service tokens
- OAuth secrets

It provides **encryption at rest**, **automatic rotation**, **fine-grained access**, and easy integration with AWS services.

---

## 🚀 Key Features

- 💾 Store key-value pairs securely
- 🔁 Auto-rotation of secrets using AWS Lambda
- 🔐 Integrated with IAM for fine-grained access control
- 🔍 Audit access via CloudTrail

---

## 🧱 Common Use Cases

- Storing RDS/MySQL credentials
- Managing API keys for third-party integrations
- Securing application secrets in EC2, ECS, Lambda, and EKS

---

## ⚙️ How to Use It

### Step 1: Create a Secret

1. Open AWS Console → Secrets Manager → “Store a new secret”
2. Choose secret type (e.g., RDS credentials or key/value pairs)
3. Name your secret (e.g., `prod/db-credentials`)
4. Store it

---

### Step 2: Access Secrets in Code (Python example)

```python
import boto3
import json

client = boto3.client('secretsmanager')
response = client.get_secret_value(SecretId='prod/db-credentials')

secret = json.loads(response['SecretString'])
username = secret['username']
password = secret['password']
```
🔐 Make sure to configure IAM roles or AWS credentials.

