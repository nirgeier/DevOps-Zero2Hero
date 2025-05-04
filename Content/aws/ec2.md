<!-- omit in toc -->
# Amazon EC2

* Amazon EC2 (Elastic Compute Cloud) is a web service from AWS that provides scalable virtual servers
in the cloud. 
* It allows you to launch and manage instances (virtual machines) with customizable CPU, memory,
storage, and networking configurations. 
* EC2 is commonly used for hosting applications, websites, and running backend services, 
offering flexibility to scale up or down based on demand. 
---


### Flexible Pricing Options

* When you launch an EC2 instance normally through the AWS console, it's On-Demand by default, but AWS offers flexible pricing options so you can choose the most cost-effective solution based on your workload.
You only pay for the compute capacity you use, and you can choose from several billing models:

  - **On-Demand Instances** - Pay per second/minute/hour with no        upfront commitment. Great for short-term or variable workloads.
  - **Spot Instances** - Even cheaper, but can be interrupted by AWS.
  - **Reserved Instances** - Lower long-term costs in exchange for a 1- or 3-year commitment.
  - **Savings Plans** - Flexible pricing model with cost reduction commitments.

---

### Networking 

* By default, EC2 instances launch into a Default VPC (Virtual Private Cloud) with preconfigured network settings.
(See more in [vpc.md](./vpc.md))

---
### Integration with Other AWS Services

Amazon EC2 integrates seamlessly with other AWS services, including:

  - **Amazon S3** – Store application data or logs.
  - **Amazon RDS** / DynamoDB – Use managed databases for applications hosted on EC2.
  - **Elastic Load Balancing (ELB)** – Distribute incoming traffic across multiple instances.
  - **Auto Scaling** – Automatically scale the number of EC2 instances up or down based on demand.
  - **AWS IAM** – Manage access control to your EC2 instances and other services securely.
  
---


<div align="center">
  <img src="/resources/images/ec2.png" width="500">
</div>


---
<!--NAVIGATION_START -->
<div style="text-align: center">

[![](https://img.shields.io/badge/Next-02--ec2--components.md-197935?style=for-the-badge&labelColor=red&width=300)](./ec2-components.md)</div>
