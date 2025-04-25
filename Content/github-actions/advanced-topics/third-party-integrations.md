<!-- omit in toc -->
<div align="center">
  <img src="/resources/images/logos/logos_github_actions.svg" alt="DevOps-Zero2Hero" width="100" style="border-radius: 25%;padd">
</div>

---

# 1. 🧩 Third-Party Integrations with GitHub Actions

## 1.1 Table of Content

- [1. 🧩 Third-Party Integrations with GitHub Actions](#1--third-party-integrations-with-github-actions)
  - [1.1 Table of Content](#11-table-of-content)
  - [1.2 💡 Why Use Third-Party Integrations?](#12--why-use-third-party-integrations)
  - [1.3 🔌 Popular Integration Examples](#13--popular-integration-examples)
    - [1.3.1 🚢 Docker Hub](#131--docker-hub)
    - [1.3.2 📨 Email Notifications](#132--email-notifications)
    - [1.3.3 📲 WhatsApp Notifications (via Twilio)](#133--whatsapp-notifications-via-twilio)
    - [1.3.4 💬 Slack Notifications](#134--slack-notifications)
  - [1.4 🤝 Other Useful Integrations](#14--other-useful-integrations)
  - [1.5 🛡️ Security Notes](#15-️-security-notes)
  - [1.6 🔚 Summary](#16--summary)

---

## 1.2 💡 Why Use Third-Party Integrations?

- It allows us to:
  - Automate deployments to external platforms like Docker Hub or AWS.
  - Send build or deployment status updates to team chat platforms.
  - Trigger actions in other tools like Jira, Gmail, or Slack.
  - Integrate testing platforms or monitoring tools into your CI/CD process.

---


## 1.3 🔌 Popular Integration Examples

### 1.3.1 🚢 Docker Hub

- We can use GitHub Actions to **build and push Docker images** directly to Docker Hub.

```yaml
- name: Log in to Docker Hub
  uses: docker/login-action@v3
  with:
    username: ${{ secrets.DOCKER_USERNAME }}
    password: ${{ secrets.DOCKER_PASSWORD }}

- name: Build and push image
  uses: docker/build-push-action@v5
  with:
    context: .
    push: true
    tags: myuser/myimage:latest
```

---

### 1.3.2 📨 Email Notifications

- We can Send an email on successful or failed jobs using dawidd6/action-send-mail.

```yaml
- name: Send email
  uses: dawidd6/action-send-mail@v3
  with:
    server_address: smtp.gmail.com
    server_port: 465
    username: ${{ secrets.EMAIL_USERNAME }}
    password: ${{ secrets.EMAIL_PASSWORD }}
    subject: Build ${{ job.status }}
    to: you@example.com
    from: GitHub Actions <you@example.com>
    body: The job has ${{ job.status }}
```
- ⚠️ Imported Tip: Use an app password with Gmail, and store it as a secret.

---

### 1.3.3 📲 WhatsApp Notifications (via Twilio)

- We can integrate WhatsApp notifications using Twilio’s API via curl or a custom script:

```yaml
- name: Notify via WhatsApp
  run: |
    curl -X POST https://api.twilio.com/2010-04-01/Accounts/${{ secrets.TWILIO_ACCOUNT_SID }}/Messages.json \
    --data-urlencode "To=whatsapp:+1234567890" \
    --data-urlencode "From=whatsapp:${{ secrets.TWILIO_NUMBER }}" \
    --data-urlencode "Body=✅ Deployment Successful!" \
    -u ${{ secrets.TWILIO_ACCOUNT_SID }}:${{ secrets.TWILIO_AUTH_TOKEN }}
```
- This requires Twilio setup and verified WhatsApp sandbox, which makes this a bit more complex compared to the other options.

---

### 1.3.4 💬 Slack Notifications

- We can send Slack messages using slackapi/slack-github-action.

```yaml
- name: Notify Slack
  uses: slackapi/slack-github-action@v1.25.0
  with:
    payload: |
      {
        "text": "🚀 Deployment completed for `${{ github.repository }}`!"
      }
  env:
    SLACK_BOT_TOKEN: ${{ secrets.SLACK_BOT_TOKEN }}
```

---

## 1.4 🤝 Other Useful Integrations

- Snyk → Security scanning for dependencies.
- SonarCloud → Code quality reports.
- Coveralls or Codecov → Code coverage reporting.
- Datadog / New Relic → Monitoring & Observability hooks.
- Jira / Asana → Issue tracking and status updates.

---

## 1.5 🛡️ Security Notes
- Always use GitHub Secrets to store sensitive values (API tokens, passwords, SMTP credentials).
- Review permissions required by third-party actions in the Marketplace.
- Enable Dependabot to keep third-party actions updated.

---

## 1.6 🔚 Summary

- Use GitHub Secrets for all sensitive data
- Review third-party actions before use!
- Pin action versions & keep them updated (use Dependabot)