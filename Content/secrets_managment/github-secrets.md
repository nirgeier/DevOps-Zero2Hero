# 🔐 GitHub Secrets

GitHub provides a secure way to store sensitive information like API keys, credentials, and tokens using **GitHub Actions Secrets**.

These secrets can be used in your CI/CD workflows without hardcoding them into your codebase.

---

## 🧠 Why Use GitHub Secrets?

- 🔒 Secrets are encrypted at rest.
- 🔐 They are not exposed in logs (unless you explicitly echo them — don't do that).
- ✋ Cannot be viewed once saved (write-only).
- 🧪 Great for CI/CD pipelines needing credentials (DockerHub, SSH keys, tokens, etc.)

---

## 🚀 How to Add a Secret

1. Go to your GitHub repository.
2. Click **Settings** → **Secrets and variables** → **Actions**.
3. Click **"New repository secret"**.
4. Add a `Name` and `Value` (e.g., `DOCKER_PASSWORD`, `SSH_KEY`, etc.)
5. Save — you're done!

---

## 📦 Using Secrets in GitHub Actions

### Example 1: Docker Login + Deployment

```yaml
name: Deploy App

on:
  push:
    tags:
      - 'v*.*.*'

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2

      - name: Log in to DockerHub
        run: echo "${{ secrets.DOCKER_PASSWORD }}" | docker login -u "${{ secrets.DOCKER_USERNAME }}" --password-stdin

      - name: Build and push Docker image
        run: |
          docker build -t my-app:${{ github.ref_name }} .
          docker push my-app:${{ github.ref_name }}
```

### Example 2: Injecting as Environment Variables

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    env:
      API_KEY: ${{ secrets.API_KEY }}
    steps:
      - run: echo "Using secret $API_KEY"
```

> ⚠️ **Do not `echo` secrets in real workflows**. It’s shown here only for syntax reference.

---

## ✅ Best Practices

- ❌ Never hardcode secrets in workflow files.
- ✅ Use secrets for DockerHub, SSH, AWS, DB passwords, and tokens.
- ✅ Rotate secrets periodically.
- ✅ Use `environment` protection rules for deployment secrets.
- ✅ Consider using organization-level secrets if shared across repos.

---

## 🧰 Pro Tips

- Use **OpenID Connect (OIDC)** instead of long-lived cloud keys for AWS or Azure.
- If you're using **deployment environments** (e.g., staging, production), you can create environment-specific secrets.
- Combine secrets with reusable workflows or matrix builds for scalable pipelines.

---

## 🔍 Troubleshooting

| Issue                             | Solution                                               |
|----------------------------------|--------------------------------------------------------|
| Secret value is not showing up   | Check name and spelling – it’s case-sensitive          |
| Secrets show in logs             | Never `echo $SECRET` directly; sanitize output         |
| Need secret across repos         | Use [organization-level secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets#using-encrypted-secrets-in-a-multi-repository-workflow) |

---

## 🔗 Resources

- 📘 [GitHub Secrets Docs](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- 🔐 [GitHub Actions Security Best Practices](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions)

---

Keep your secrets safe — your CI/CD pipeline depends on them.
