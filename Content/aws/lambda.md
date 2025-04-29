# AWS Lambda: Run Code, Skip Servers 

AWS Lambda lets you run code without managing servers. Upload your code, and Lambda Lambda takes care of scaling, updates, and infrastructure.
You only pay for what you use.

##  1. What is Lambda?

Lambda is a **serverless** service that runs your code when triggered by events (like an HTTP request or a file upload). No servers to manage, just code that responds to what’s happening.

##  2. Lambda Functions

A **Lambda function** is your code plus its setup. It’s what runs when an event triggers it.

- **Key Stuff**:
  - Write in Python, Node.js, Java, etc.
  - Upload as a ZIP or container, or edit in the AWS console.
  - The **handler** is the function Lambda calls.

##  3. Triggers

Triggers are things that start your Lambda function.

- **Examples**:
  - **S3**: New file uploaded? Run your code.
  - **API Gateway**: HTTP request? Trigger your function.
  - **CloudWatch**: Run on a schedule (like every hour).

##  4. How It Runs

Lambda creates a temporary, isolated environment for your code.

##  5. Permissions

Your function needs an **IAM Role** to talk to other AWS services (like read from S3).

##  6. Scaling & Cost

Lambda scales automatically—each event gets its own instance.

- **Pricing**:
  - Pay per invocation and runtime (first 1M requests free).
  - Monitor with CloudWatch to avoid surprises.


