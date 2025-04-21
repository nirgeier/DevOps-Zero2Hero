## SUBNETS:
### PRIVATE SUBNETS:
Private subnets are not directly accessible from the internet, but can be accessed 
through a NAT gateway or VPN.
It increase network security by isolating systems.
Private subnets can communicate with other subnets in the same VPC.

### PUBLIC SUBNETS:
Public subnets are accessible over the internet, and in AWS, are connected to an Internet Gateway.
These subnets are used when resources need to be directly accessible online.
Because their vulnerability to attacks They require security measures.

## ROUTE TABLE:
A route table directs network traffic based on destination IP addresses.
Each subnet in a VPC is associated with one route table.

## INTERNET GATEWAY:
IGW Connects a network to the internet.
Enables VPC instances(=machines) to access the internet.
Allows internet users to access public resources within the VPC.

## NAT GATEWAY:
Allows private network devices to access the internet and 
it Provides public IP address to these devices.

## ELASTIC IP:
An Elastic IP is a static, public IPv4 address used in AWS.
It's associated with your AWS account, not a specific instance(for case that instance is fall down 
in cluster for example, it doesnt change the IP address when another instance will create).
We will use it mostly when hosting websites or applications for a reliable IP address.
