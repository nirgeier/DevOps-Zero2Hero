<!-- omit in toc -->
<div align="center">
  <img src="/Content/github-actions/resources/logos/github-security.png" alt="DevOps-Zero2Hero" width="100" style="border-radius: 25%;padd">
</div>

---

# 1. 🔐 Security & Best Practices in GitHub Actions

## 1.1. Table of Content

- [1. 🔐 Security \& Best Practices in GitHub Actions](#1--security--best-practices-in-github-actions)
  - [1.1. Table of Content](#11-table-of-content)
  - [1.2 🔑 Secrets Management](#12--secrets-management)
    - [1.2.1 📌 Best Practices:](#121--best-practices)
  - [1.3 🧬 OpenID Connect (OIDC) Authentication](#13--openid-connect-oidc-authentication)
    - [1.3.1 📦 Example: OIDC with AWS](#131--example-oidc-with-aws)
  - [1.4 🔒 Workflow Hardening Tips](#14--workflow-hardening-tips)
    - [1.4.1 🔒 Fine-Grained Access: permissions Block](#141--fine-grained-access-permissions-block)
  - [1.5 🔚 Summary](#15--summary)

---

<div align="center">
  <img src="/resources/images/cover-rounded.png" alt="DevOps-Zero2Hero" width="500">
</div>

---

## 1.2 🔑 Secrets Management

- Use GitHub’s built-in [Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets) to store sensitive information like:
  - API keys
  - Access tokens
  - Cloud credentials
- For example:
```yaml
- name: Use secret API key
  run: echo "API key is ${{ secrets.MY_SECRET }}" # The name of the API key variable is MY_SECRET
```

---

### 1.2.1 📌 Best Practices:
- Use repository/environment-level secrets, not hardcoded values.
- Rotate secrets periodically.
- Never echo secrets in logs unless redacted.

---

## 1.3 🧬 OpenID Connect (OIDC) Authentication

- OIDC is a modern, passwordless way for Github Actions to authenticate with cloud providers (e.g., AWS, Azure, GCP) **without storing long-lived secrets.**

---

### 1.3.1 📦 Example: OIDC with AWS

- Configure an IAM role with a trust policy allowing GitHub's OIDC provider.
- Use the aws-actions/configure-aws-credentials action:

```yaml
- name: Configure AWS credentials
  uses: aws-actions/configure-aws-credentials@v2 # Can be found in the marketplace
  with:
    role-to-assume: arn:aws:iam::123456789012:role/MyOIDCRole
    aws-region: us-east-1
```
- You can learn more about AWS OIDC here: [AWS OIDC Setup Guide](https://docs.github.com/en/actions/security-for-github-actions/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)

---

## 1.4 🔒 Workflow Hardening Tips

| Recommendation                    | Why it matters                                           |
|----------------------------------|----------------------------------------------------------|
| Use specific action versions (@v3) | Prevents breaking changes from updates                  |
| Validate inputs using `if`        | Avoids accidental or malicious triggers                 |
| Use minimal permissions           | Follows the principle of **least privilege**                |
| Review third-party actions        | Ensure you're not importing malicious or outdated code  |
| Avoid exposing secrets in logs    | Even indirectly via error messages or `echo` commands   |

---

### 1.4.1 🔒 Fine-Grained Access: permissions Block

- You can explicitly control what the workflow can access:
```yaml
permissions:
  contents: read
  id-token: write  # Required for OIDC
```
- You need to set this at the job or workflow level.
- If not defined, the default is often broader than necessary.

---

## 1.5 🔚 Summary
- Use GitHub Secrets for all sensitive data
- Prefer OIDC over long-lived cloud keys
- Pin action versions & audit third-party actions
- Use minimal permissions and validate inputs
- Enable manual approvals for production
