# Application Load Balancer (ALB)

An **Application Load Balancer (ALB)** is a fully managed AWS service that intelligently distributes incoming application traffic across multiple targets (such as EC2 instances, containers, or Lambda functions).  
It operates at **Layer 7 (Application Layer)** of the OSI model, which means it understands HTTP/HTTPS traffic and can make routing decisions based on content (URLs, headers, methods, cookies, etc).  

ALBs improve availability, scalability, and security of your applications by ensuring traffic is balanced and fault-tolerant.

---

## Why Do We Need an ALB?
- **High Availability**: Automatically distributes requests across multiple Availability Zones.
- **Scalability**: Handles sudden spikes in traffic by distributing load efficiently.
- **Intelligent Routing**: Routes requests based on content (e.g., `/api/*` goes to microservice A, `/images/*` goes to microservice B).
- **Security Integration**: Works seamlessly with AWS WAF (Web Application Firewall), ACM (SSL/TLS certificates), and IAM.
- **Serverless Support**: Can route traffic not only to EC2 or ECS, but also to AWS Lambda functions.
- **Central Entry Point**: Acts as a single point of access to multiple backend services, simplifying architecture.

---

## Key Components of an ALB

### 1. Listeners
- A listener is a process that checks for connection requests using a configured protocol and port.  
- Common protocols: **HTTP (port 80)**, **HTTPS (port 443)**.  
- Each listener has one or more **rules** that define how to route requests.

### 2. Rules
- Rules determine how requests are routed.  
- Each rule consists of:
  - **Conditions**: Criteria to evaluate (e.g., path `/app1/*`, host `api.example.com`, HTTP headers).
  - **Actions**: What to do when conditions are met (e.g., forward to a target group, redirect, return fixed response).  
- Rules are evaluated in **priority order** (lowest number = highest priority).

### 3. Target Groups
- Logical groups of targets (EC2 instances, ECS tasks, Lambda functions, IPs).  
- Requests are routed to the appropriate target group based on rules.  
- Health checks are configured at the target group level to ensure only healthy targets receive traffic.

### 4. Health Checks
- ALB continuously monitors registered targets to ensure they are healthy.  
- If a target fails health checks, traffic is automatically rerouted to healthy targets.  
- Configurable options include path (`/health`), interval, timeout, and thresholds.

### 5. Availability Zones
- ALB can distribute traffic across multiple Availability Zones for resilience.  
- Ensures application availability even if one AZ experiences failure.

### 6. Security Features
- Integrated with **Security Groups** (stateful firewalls at instance level).  
- Supports **AWS WAF** for protection against common web exploits.  
- Works with **AWS ACM** for managed SSL/TLS certificates.  

---

## Typical ALB Workflow
1. **Client** sends a request to the ALB’s DNS name.  
2. **Listener** (e.g., HTTPS:443) receives the request.  
3. **Rule** checks the path/host/headers and decides which **Target Group** to forward to.  
4. **Health Checks** ensure traffic is only sent to healthy targets.  
5. **Targets** (EC2, ECS, Lambda) process the request and send response back to client via ALB.  

---

## Example Use Cases
- **Microservices Architecture**: Route `/api/*` to ECS tasks, `/static/*` to S3 via CloudFront.  
- **Blue/Green Deployments**: Use rules to split traffic between two target groups for zero-downtime updates.  
- **Serverless Applications**: Route API requests directly to AWS Lambda.  

---

## Comparison with Other Load Balancers

| Feature                     | Classic LB (CLB)     | Network LB (NLB)      | Application LB (ALB)   |
|-----------------------------|----------------------|-----------------------|------------------------|
| OSI Layer                   | 4 & 7               | 4 (TCP/UDP)           | 7 (HTTP/HTTPS)         |
| Intelligent Routing         | Basic               | No (only transport)   | Yes (content-based)    |
| Protocols                   | HTTP, HTTPS, TCP     | TCP, UDP, TLS         | HTTP, HTTPS, gRPC      |
| Performance                 | Good                | Ultra-high (millions) | High, optimized for web|
| Best Use Case               | Legacy apps         | Low-latency, high TPS | Web apps, microservices|

---

## Quick Setup Steps
1. Create an **ALB** inside your VPC (choose subnets across at least 2 AZs).  
2. Add **Listeners** for HTTP (80) and/or HTTPS (443).  
3. Create **Target Groups** and register your backend services.  
4. Configure **Routing Rules** to forward requests based on conditions.  
5. Attach **Security Groups** and (optional) **WAF** for protection.  
6. Point your **DNS (Route 53)** to the ALB’s DNS name.  

---

⚡ **In summary**:  
An **Application Load Balancer (ALB)** is a modern, intelligent, and secure load balancer that distributes application traffic at **Layer 7**, supports content-based routing, health checks, SSL termination, and deep integration with AWS services.

