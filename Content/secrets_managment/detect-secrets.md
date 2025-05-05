### 📁 `detect-secrets.md`

# 🔍 Scanning and Detecting Secrets in Code

Even with best practices, secrets may accidentally get committed to Git. These tools help you **detect and prevent** that before it becomes a security issue.

---

## 🧰 Recommended Tools

### 1. **Gitleaks** (by zricethezav)

```bash
# Install
brew install gitleaks

# Scan your repo
gitleaks detect --source .
Fast and configurable
```
- Can be used in CI pipelines

- Supports custom regex rules

### 2. TruffleHog
```bash
pip install trufflehog
trufflehog github --repo=youruser/yourrepo
```
- Searches for high-entropy strings and known secret patterns

- Supports GitHub, GitLab, and local repos

### 3. git-secrets (by AWS)
```bash
git clone https://github.com/awslabs/git-secrets.git

cd git-secrets && sudo make install

git secrets --install
```
- Prevents committing secrets in the first place

- Integrates with Git hooks

### ✅ Best Practices
- Run scanning tools pre-commit or in CI/CD

If a secret is leaked:

1. Revoke immediately

2. Rotate and update deployments

3. Audit access logs

- Add .env and config files to .gitignore

