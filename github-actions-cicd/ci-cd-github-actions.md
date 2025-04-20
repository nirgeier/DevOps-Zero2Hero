<!-- omit in toc -->
# What is GitHub Actions?

GitHub Actions is a continuous integration and continuous delivery (CI/CD) platform that allows you to automate your build, test, and deployment pipeline.

---

## 🛠️ Example of a simple CI/CD Workflow using GitHub Actions (Python)

This is a basic CI/CD pipeline using **GitHub Actions** for a Python project.  
It runs automatically on every push to the `main` branch and includes the following steps:

- Checkout the code.
- Set up Python.
- Install dependencies from `requirements.txt`.
- Run test suite (using `unittest` or `pytest`).
- Simulate a deploy step (for demonstration purposes).

```yaml
name: Simple Python CI/CD

on:
  push:
    branches: [ "main" ]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.10'

      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -r requirements.txt

      - name: Run tests
        run: |
          echo "Running tests..."
          python -m unittest discover tests

      - name: Deploy (simulated)
        run: echo "🚀 Deploying the Python app..."
```

## Diagram of the Workflow

[Code Push to GitHub]
         ↓
[Trigger GitHub Action]
         ↓
[Run Jobs (Build, Test, Deploy)]
         ↓
[Success ✅ or Fail ❌]

---

## Tips for Beginners

- Always test your workflow in a separate branch before merging.
- Use `secrets` in GitHub to store credentials (like API keys).
- Check the [Actions Marketplace](https://github.com/marketplace?type=actions) to find reusable actions.

---

## Useful Resources

- [GitHub Actions Docs](https://docs.github.com/en/actions)
- [Awesome Actions](https://github.com/sdras/awesome-actions)
- [Actions Marketplace](https://github.com/marketplace?type=actions)

---



