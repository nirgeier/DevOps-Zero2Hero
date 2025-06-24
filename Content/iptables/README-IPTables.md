# Welcome to the IPTables Tutorial

This tutorial covers the fundamentals of iptables, including introduction, different tables, chains, Use-Cases and Examples.

## Table of Contents

1. [Iptables Introduction](#iptables-introduction)
2. [Iptables Tables](#tables)
3. [Iptables Chains](#chains)
4. [Iptables Use-Cases](#use-cases)


---

## Iptables Introduction

iptables is a powerful command-line utility in Linux used to set up, maintain, and inspect the packet filtering rules of the Linux kernel firewall. It allows system administrators to control the incoming and outgoing network traffic based on a set of rules, helping to secure servers and enforce network policies.

Under the hood, iptables works with the Netfilter framework, which is part of the Linux kernel. It supports filtering packets based on IP addresses, ports, protocols, interfaces, and connection states.

---

## Tables
### What Are Tables in iptables?
In iptables, tables are logical groupings of rules that define how the Linux kernel should handle different types of network packets.Each table is designed for a specific kind of packet processing, such as filtering, NAT (network address translation), or packet alteration. Think of tables as modules in the firewall system — each one focuses on a specific task, and within each table are chains that contain the actual rules.

###  Key Tables in iptables
- filter: Default table for allowing or blocking traffic (firewall)
- nat:	Handling network address translation, e.g., port forwarding, SNAT/DNAT
- mangle:	Altering packet headers for QoS, TTL, marking

## Chains
### What Are Chains in iptables?
In iptables, a chain is an ordered list of rules that a packet is checked against. Each rule in a chain matches certain packet characteristics (like IP address, port, protocol) and defines an action (called a target) to take when a match occurs — such as ACCEPT, DROP, or REJECT.

Chains are part of tables, and each table contains specific chains depending on its purpose.

There are two types of chains:

#### Built-in Chains
These are predefined by the system and always exist within specific tables. The most common built-in chains are:

- INPUT: Handles packets destined for the local system.

- OUTPUT: Handles packets originating from the local system.

- FORWARD: Handles packets passing through the system (i.e., routed).

- PREROUTING: Alters packets before the routing decision.

- POSTROUTING: Alters packets after the routing decision.

#### User-defined Chains
You can also create your own custom chains to organize rules logically or reuse logic. A rule in a built-in chain can jump to a user-defined chain, which runs like a function.

## Use-Cases
### 🐳 1. Docker Networking and NAT
What happens:

Docker uses iptables rules to isolate containers, expose ports, and provide NAT for outbound traffic. When you run a container with port mapping (-p 8080:80), Docker creates iptables rules like:

```bash
# Allow inbound traffic to the container
-A DOCKER -d <host_ip>/32 ! -i docker0 -o docker0 -p tcp --dport 8080 -j DNAT --to-destination <container_ip>:80
```
#### Chains involved:

- Docker creates its own user-defined DOCKER chain.

- Uses the nat table for DNAT (host:port → container:port).

- Uses filter table for access control.

- The POSTROUTING chain handles SNAT/masquerade so containers can reach the outside world.

#### Why iptables:

- Docker manipulates iptables directly to isolate networks and implement port forwarding.

- Without iptables, containers wouldn’t be safely exposed or routed.

### 🌐 2. CNI (Container Network Interface) Plugins
#### What happens:

CNI plugins (used in Kubernetes or container runtimes) also configure network rules via iptables:

- Calico, Flannel, and Cilium use iptables for pod isolation, routing, and NAT.

- When a pod starts, the CNI plugin adds rules to allow traffic to/from that pod.

#### Chains/tables used:

- nat: SNAT for outbound pod traffic (masquerade)

- filter: enforce NetworkPolicies (e.g., Calico uses custom chains like calico-packet-filter)

- mangle: tag/mark packets for routing/QoS

### 🔐 3. Basic Server Access Security
#### What happens:

You can use iptables to lock down a public-facing server, allowing only necessary services (e.g., SSH, HTTP/S) and denying the rest:

```bash
# Default deny
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Allow loopback
iptables -A INPUT -i lo -j ACCEPT

# Allow SSH from specific IP
iptables -A INPUT -p tcp -s 203.0.113.5 --dport 22 -j ACCEPT

# Allow HTTP/HTTPS
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
```
#### Chains used:

- filter table: INPUT, OUTPUT, FORWARD

### 🌍 4. VPN Gateway / Router with DNAT + MASQUERADE
Scenario: A Linux server acting as a VPN or router for internal clients. External traffic to a public IP should be routed to internal services, and internal users should reach the internet via NAT.

#### 🧭 DNAT (Destination NAT) – Port Forwarding
Redirect incoming traffic on port 443 to an internal server:

```bash
# Redirect port 443 on public IP to internal web server
iptables -t nat -A PREROUTING -p tcp -d <public_ip> --dport 443 -j DNAT --to-destination 192.168.1.100:443
```
#### 🧼 MASQUERADE – Source NAT for Outgoing Traffic
Allow internal clients to access the internet:

```bash
# Rewrite source IP for internal traffic to appear as the router’s public IP
iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -o eth0 -j MASQUERADE
```
#### 🔒 Allow forwarding:

```bash
# Enable packet forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward
# Allow the forwarded packets
iptables -A FORWARD -i tun0 -o eth0 -j ACCEPT
iptables -A FORWARD -i eth0 -o tun0 -m state --state ESTABLISHED,RELATED -j ACCEPT
```