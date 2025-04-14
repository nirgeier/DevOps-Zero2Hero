# Secrets 

## What Are "Secrets" in DevOps?

- Secrets are any sensitive pieces of data that should not be exposed publicly. 

Examples include:
- API keys
- SSH keys
- Database credentials
- OAuth tokens
- Access tokens
- TLS certificates
- Cloud provider keys (AWS/GCP/Azure)
- They are required for authenticating your app or deployment scripts — but must be protected from leaks.

## ⚠️ What Can Go Wrong?

- Secrets committed to Git = Permanent exposure
- Exposed secrets can lead to cloud resource hijacking, data breaches, or production takedown
- Many companies have been compromised just from a leaked .env file or a hardcoded key
> [!TIP] 📌 Real-life tip
> GitHub scans public repos for secrets and may auto-revoke credentials.

## ✅ Best Practices for Secret Management

- Never commit secrets to Git
- Use `.gitignore` 
- Use `.env` and config files.
- Double-check before pushing: git status
- Use environment variable
- Define secrets in secrets section of CI/CD tools.
  - Access them via environment variables in scripts.
- Rotate secrets regularly
- Just like passwords. Automate it where possible.
- Use a centralized secrets manager
- **Don’t store secrets in plain text files.**