<!-- omit in toc -->
<div align="center">
  <img src="/resources/images/logos/github-actions-logo.png" alt="DevOps-Zero2Hero" width="100" style="border-radius: 25%;padd">
</div>

---

# 1. 🛒GitHub Actions Marketplace & Reusable Templates

## 1.1. Table of Content

- [1. 🛒GitHub Actions Marketplace \& Reusable Templates](#1-github-actions-marketplace--reusable-templates)
  - [1.1. Table of Content](#11-table-of-content)
  - [1.2 ❓What is the GitHub Actions Marketplace?](#12-what-is-the-github-actions-marketplace)
    - [1.3 📦 Example: Using an Official Action](#13--example-using-an-official-action)
  - [1.4 🧩 What Are Reusable Workflows?](#14--what-are-reusable-workflows)
    - [1.5 🧪 Example: Calling a Reusable Workflow](#15--example-calling-a-reusable-workflow)
  - [1.6 ✅ When Should You Use These?](#16--when-should-you-use-these)
  - [1.7 🛡️ Trust and Security Tips](#17-️-trust-and-security-tips)
  - [1.8 🔚 Summary](#18--summary)

---

<div align="center">
  <img src="/resources/images/cover-rounded.png" alt="DevOps-Zero2Hero" width="500">
</div>

---

## 1.2 ❓What is the GitHub Actions Marketplace?
- The [GitHub Actions Marketplace](https://github.com/marketplace?type=actions) is a public directory of reusable, prebuilt actions that solve common automation tasks. These include:

  - Setting up programming environments
  - Uploading/downloading artifacts
  - Running tests, sending notifications, and more

- There are thousands of open-source actions provided by the community and partners to simplify tasks and automate processes.

---

### 1.3 📦 Example: Using an Official Action

- Here’s how you can use a popular action from the marketplace to set up Python in a workflow:

```yaml
- name: Set up Python
  uses: actions/setup-python@v4 # actions/ indicates that we use an action from the marketplace 
  with:
    python-version: '3.10'
```

- This automatically downloads and caches the correct Python version.

---

## 1.4 🧩 What Are Reusable Workflows?

- **Reusable workflows** are entire .yaml/.yml files that can be referenced in other workflows — just like functions in code.
- They help you keep things consistent across projects.

---

### 1.5 🧪 Example: Calling a Reusable Workflow

- Suppose we have a reusable workflow that looks like this:

```yaml
# .github/workflows/test.yml
on:
  workflow_call:
    inputs:
      node_version:
        required: true
        type: string

jobs:
  run-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: ${{ inputs.node_version }}
      - run: npm install && npm test
```

- We can **reuse** this from abother repository:

```yaml
# .github/workflows/call-test.yml
name: Call Reusable Test

on: [push]

jobs:
  test:
    uses: my-org/my-repo/.github/workflows/test.yml@main
    with:
      node_version: '18'
```
- The calling workflow can be in the same repository or a different one (as long as it’s public or accessible).

---

## 1.6 ✅ When Should You Use These?

| Scenario                             | Use Marketplace | Use Reusable Workflow |
|--------------------------------------|------------------|------------------------|
| Install tools (e.g., Node, Python)   | ✅ Yes           | ❌ Not needed          |
| Standard CI pipeline across repos    | ❌ Too low-level | ✅ Yes                 |
| Simple deployment to Firebase, S3 etc.| ✅ Yes           | ✅ Maybe               |
| Building custom enterprise flows     | ❌               | ✅ Definitely          |

---

## 1.7 🛡️ Trust and Security Tips
- Use official GitHub actions (e.g., actions/*) when possible.
- If using community actions, pin to a commit SHA or tag (@v1, @v3.2.1) to avoid unexpected changes.
- Avoid using unverified or poorly maintained actions.

---

## 1.8 🔚 Summary
- The Marketplace offers thousands of plug-and-play actions.
- Reusable workflows help enforce consistency and reduce duplication.
- Use them together to build cleaner, modular pipelines.