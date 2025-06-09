# Welcome to the IPTables Tutorial

This tutorial covers the fundamentals of iptables, including introduction, different tables, filter chains, Use-Cases and Examples.

## Table of Contents

1. [Linux Introduction](#iptables-introduction)
2. [Linux Environment Variables](#tables)
3. [Linux File Management](#filter-chains)
4. [Linux Input/Output (I/O) Redirection](#use-cases)
5. [Linux Package Management](#examples)

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