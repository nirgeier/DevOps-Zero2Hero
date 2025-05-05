<!-- omit in toc -->
<div align="center">
  <img src="/resources/images/logos/logos_github_actions.svg" alt="DevOps-Zero2Hero" width="100" style="border-radius: 25%;padd">
</div>

---

# 1.🌍 Environments & Approvals

## 1.1 Table of Content

- [1.🌍 Environments \& Approvals](#1-environments--approvals)
  - [1.1 Table of Content](#11-table-of-content)
  - [1.2 ❓ What Are Environments?](#12--what-are-environments)
  - [1.3 ✅ Setting Up Manual Approvals](#13--setting-up-manual-approvals)
    - [1.3.1 ⚙️ Example Workflow with Manual Approval](#131-️-example-workflow-with-manual-approval)
  - [1.4 🔐 Scoped Secrets by Environment](#14--scoped-secrets-by-environment)
  - [1.5 🔚 Summary](#15--summary)

---

## 1.2 ❓ What Are Environments?

- **GitHub Environments** allow you to define deployment targets like staging, production, or testing. 
- With **required approvals**, you can enforce manual reviews before code reaches critical environments like production.
- Environments in GitHub Actions represent distinct stages in your deployment pipeline.
- Each environment can have:
  - Environment-specific **secrets**
  - **Required reviewers** for manual approval
  - **Wait timers** or **deployment history**
  - Protection rules like restricted branches

---

## 1.3 ✅ Setting Up Manual Approvals

  - Go to **Repository Settings → Environments**.
  - Click **New Environment** and name it (e.g., production).
  - Add **required reviewers** under the environment settings.
  - Once triggered, the workflow will **pause** until a reviewer approves the deployment.

---

### 1.3.1 ⚙️ Example Workflow with Manual Approval

```yaml
name: Deploy to Production

on:
  workflow_dispatch:

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment:
      name: production
      url: https://your-app.example.com

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Deploy to production
        run: echo "Deploying to production..."
```
- ⚠️ In GitHub settings, configure the production environment to require **manual approval**.

---

## 1.4 🔐 Scoped Secrets by Environment

- You can define secrets that are only available for a specific environment:

```yaml
- name: Use environment secret
  run: echo "The token is ${{ secrets.PROD_API_KEY }}"
```
- Only the job running in the production environment will have access to PROD_API_KEY.

---

## 1.5 🔚 Summary
- Use environments to separate deployment stages.
- Add manual approvals to prevent accidental production pushes.
- Store secrets securely per environment.
- Audit deployment history and status via the GitHub UI.
- Combine with reusable workflows or OIDC for powerful delivery pipelines.