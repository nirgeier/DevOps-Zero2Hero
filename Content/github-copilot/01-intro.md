<img src="../../resources/images/logos/logos_copilot.svg" style="border-radius: 25px; padding: 10px; width:100px"/>


<!-- omit in toc -->
# GitHub Copilot Setup and Configuration Guide

<!-- omit in toc -->
## Table of Contents

- [1. Introduction](#1-introduction)
- [2. What is GitHub Copilot?](#2-what-is-github-copilot)
- [3. Features of GitHub Copilot](#3-features-of-github-copilot)
- [4. What is GitHub Copilot Used For?](#4-what-is-github-copilot-used-for)
- [5. Pre-Requisites](#5-pre-requisites)
  - [5.1. Install VsCode \& GitHub Copilot](#51-install-vscode--github-copilot)
- [6. Configure GitHub Copilot](#6-configure-github-copilot)

---

## 1. Introduction

- This guide will walk you through the process of setting up and configuring GitHub Copilot on your VsCode editor. 
- GitHub Copilot is an AI-powered coding assistant that helps developers write better code faster. 
- It uses the power of artificial intelligence (AI)to provide intelligent code suggestions, auto-completion, and even help with debugging.
- GitHub Copilot is available for free and can be used on any platform that supports
the VSCode editor.

## 2. What is GitHub Copilot?

GitHub Copilot is an AI-powered coding assistant developed by GitHub. It uses the power of artificial intelligence to help developers write better code faster. Copilot provides intelligent code suggestions, auto-completion, and even helps with debugging.

## 3. Features of GitHub Copilot

- **AI-Powered Suggestions**: Get context-aware code suggestions
- **Multi-Language Support**: Works with most popular programming languages
- **Real-Time Assistance**: Helps while coding in real-time
- **Code Review**: Assists with code reviews and provides feedback
- **Integration with VSCode**: Seamless integration with Visual Studio Code
- **Customizable**: Configure settings to match your coding style

## 4. What is GitHub Copilot Used For?

- **Code Completion**: Automatically completes code snippets
- **Code Generation**: Generates boilerplate code
- **Debugging Assistance**: Helps identify and fix errors
- **Code Review**: Provides suggestions for improving code quality
- **Documentation**: Assists with writing code comments and documentation
- **Learning**: Helps developers learn new programming concepts


## 5. Pre-Requisites

- To use GitHub Copilot, you need to have the following:
  - GitHub account
  - VSCode editor

### 5.1. Install VsCode & GitHub Copilot

- To start using GitHub Copilot as described in this guide, you need to install VSCode.
- Download and install VSCode from the official website or use the package manager of your choice.
- If you don't have a GitHub account, you can sign up for a free account under your GitHub account profile, or from [GitHub Copilot website](https://copilot.github.com/) and install it directly from there.
<img src="../../resources/images/copilot/copilot_install.png">
- Another option is to install it from the VSCode marketplace using the cli:  

  ```bash
  #!/bin/bash

  # Install GitHub Copilot extension for VSCode using CLI
  code --install-extension "GitHub.copilot"
  echo "GitHub Copilot extension installed successfully!"
  ```

---
 
## 6. Configure GitHub Copilot

- Once installed, you can start using GitHub Copilot
- After installing GitHub Copilot, you need to configure it to work with your
  - Open Visual Studio Code
  - Click on the "Extensions" icon in the left sidebar
  - Search for `GitHub Copilot` in the Extensions Marketplace
  - Click on the "Install" button if not already installed in as described above.
  - Click on the wrench (Gear) icon in the left sidebar and select "Extensions"
  <img src="../../resources/images/copilot/copilot_account_preference.png" style="border-radius: 25px; margin-top: 20px;"/>
  - Choose the `Account Preferences" option
  - Enter your GitHub username and follow the instructions to link your GitHub account 

---


> [!Note] Now that you have GitHub Copilot installed and configured, you can start using it to write better code faster. 


---
<!--NAVIGATION_START -->
<div style="text-align: center">

[![](https://img.shields.io/badge/Next-02--copilot--kickstart.md-197935?style=for-the-badge&labelColor=red&width=300)](./02-copilot-kickstart.md)</div>
