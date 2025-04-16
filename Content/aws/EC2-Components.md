# 🔧 1. EC2 Instances:
An EC2 instance is a virtual server running in Amazon’s cloud, similar to a physical server
in a data center, but fully managed and scalable.
It’s where your code, apps, or services actually run.

# 📦 2. Amazon Machine Images (AMIs):
An AMI is a template used to create EC2 instances. 
It includes everything needed to launch a virtual server: the operating system, 
any pre-installed software, configurations, etc.
Think of it like a blueprint (or like snapshot in VM for instance) of a computer 
that you can use to launch as many identical EC2 instances as you need.

When launching an instance, the first thing AWS asks is: "Which AMI do you want to use?" 
You can pick from the AWS Marketplace, your own AMIs, or community/shared ones.


# 🏷️ 3. Instance Types:
Instance types define the hardware configuration (CPU, memory, storage, and networking capacity) 
for your EC2 instance.
You can resize your instance later by stopping it and changing the 
instance type — very useful as your workload grows.

# 🌐 4. Security Groups:
A Security Group acts like a virtual firewall for your EC2 instances. 
It controls inbound and outbound traffic at the **instance level** — deciding who can connect to your EC2 
and what kind of traffic is allowed in or out.

You assign one or more security groups when you launch an instance, and you can modify them anytime.

### Important Things to Know:
- `Stateful:` If you allow inbound traffic on a port, response traffic is automatically allowed out.

- `No Deny Rules:` You can only allow traffic, not explicitly block it.

- `Multiple Groups:` You can attach multiple security groups to an instance — the rules are additive.

# 🗺️ 5. Key Pairs:
A Key Pair is used to securely access your EC2 instance. It's a combination of:

Public key – Stored by AWS and embedded into your instance.

Private key – Downloaded by you, and kept safe on your machine.

Together, they enable SSH(Secure shell) access to Linux instances or RDP(Remote desktop) access to Windows instances without using passwords.

### 🔒 Important Notes:
You only get one chance to download the .pem file(the private key) — **store it safely!**

Do not share your private key. Anyone with it can access your instance.

# 🧱 6. Elastic Block Store (EBS):
Amazon EBS is block-level storage that you can attach to EC2 instances, just like a virtual hard drive. It’s designed for persistent, high-performance storage — great for things like OS boot volumes, databases, app data, and logs.

### 🛠️ How EBS Works with EC2:
Every EC2 instance has at least one EBS volume (the root volume).
You can add additional volumes (e.g., a separate volume just for data).
If you stop and restart your instance, the EBS volumes stay attached.
If you terminate the instance, the volume is deleted only if "delete on termination" is enabled.

- EBS snapshots are **incremental** backups of your volume.

# 📶 7. Elastic IPs:
An Elastic IP is a static, public IPv4 address that you can associate with your EC2 instance. 
Unlike regular public IPs, Elastic IPs don’t change when you stop or restart your instance — making them perfect for situations where a consistent IP address is needed (e.g., DNS records, whitelisted services, APIs, etc.).
