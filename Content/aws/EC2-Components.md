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
- 'Stateful:' If you allow inbound traffic on a port, response traffic is automatically allowed out.

- 'No Deny Rules:' You can only allow traffic, not explicitly block it.

- 'Multiple Groups:' You can attach multiple security groups to an instance — the rules are additive.

# 🗺️ 5. Key Pairs:

# 🧱 6. Elastic Block Store (EBS):

# 📶 7. Elastic IPs:

# 📈 8. Auto Scaling:




