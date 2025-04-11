# 🐳 Docker Lab: Hello Web Server

This lab teaches you how to create a simple Dockerized web server, run it with Docker Compose, and automate image publishing with GitHub Actions.

Detailed commands and how to build each file is specified in the other README files.


---
## Prerequisites
Before you begin, ensure you have the following installed:
- 🖥️ [Docker for Windows](https://www.docker.com/products/docker-desktop/)
- 🐧 [Docker for Linux](https://docs.docker.com/engine/install/)
- 🔡 Git (for cloning the repo)

---
### 📁 Project Structure

my-project/
├── app/                 ← source files (e.g., HTML, app code)
│   └── index.html
├── Dockerfile           ← Docker build instructions
├── docker-compose.yml   ← multi-service orchestration
├── .dockerignore        ← exclude files from Docker build context
├── README.md            ← project instructions
└── .github/
    └── workflows/
        └── docker-publish.yml  ← CI/CD pipeline

Here is the basic structure for example : 

Docker/
├── Dockerfile
├── docker-compose.yml
├── app/
│   └── index.html

---

#### 🚀 Quick Start
1. Navigate to your project directory: 
```bash
cd path/to/Docker
```
2. Run the Command : 
```bash
docker-compose up --build
```
3. Open your browser and visit : 
http://localhost:8080


