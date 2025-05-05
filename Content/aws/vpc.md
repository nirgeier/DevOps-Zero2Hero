# VPC

A Virtual Private Cloud (VPC) is a private, isolated network within a cloud environment, 
like AWS, where users can define and control their own network settings. 
It allows you to securely launch and manage resources, such as virtual machines and databases, 
in a private environment.

Within a VPC, you can configure subnets, IP addresses, routing and security settings, ensuring that your 
cloud resources are isolated from others while maintaining secure communication between them.

## Key AWS VPC Networking Components:

- **Subnets:** Segments of the VPC's IP address range. 
- **Internet Gateway:** A gateway attached to your VPC that enables communication between resources in your VPC and the internet.
- **NAT Gateway:** Allows instances in a private subnet to access the internet without exposing them to inbound traffic from the internet. 
- **Route Tables:** Sets of rules that determine how traffic is directed within your VPC and beyond. 
- **Network Access Control Lists (NACLs):** Stateless firewalls that control inbound and outbound traffic at the subnet level.
- **Security groups:**  Stateful virtual firewalls that control inbound and outbound traffic at the instance level. Unlike NACLs, security groups remember the state of a connection (i.e., if inbound is allowed, the response is automatically allowed outbound).
- **VPC Peering:** Connects two VPCs privately. 
- **Elastic IP addresses:** Static IPv4 addresses for your account.
---
### Default VPC

When you create a new EC2 instance, AWS automatically selects the default VPC, which comes pre-configured with:

- A /16 IPv4 CIDR block: 172.31.0.0/16
- An Internet Gateway attached to the VPC
- A main route table with a route that sends all traffic (0.0.0.0/0) to the Internet Gateway
- A default security group associated with the VPC
- Three subnets, each in a different Availability Zone within the region

---

<div align="center">
  <div style="display: inline-block; margin-right: 10px;">
    <img src="/resources/images/default-vpc.png" width="300">
  </div>

