#!/bin/bash

# Flush all existing rules
iptables -F

# Set default policies
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Allow loopback traffic
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Allow established connections
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# Allow SSH (change 22 to your SSH port if needed)
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Allow HTTP and HTTPS
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Allow DNS (change 53 to your DNS port if needed)
iptables -A INPUT -p udp --dport 53 -j ACCEPT
iptables -A INPUT -p tcp --dport 53 -j ACCEPT

# Allow ICMP (optional, enable if needed)
iptables -A INPUT -p icmp -j ACCEPT

# Drop traffic over TCP & UDP port 4444
iptables -A INPUT -p tcp --dport 4444 -j DROP
iptables -A INPUT -p udp --dport 4444 -j DROP

# Drop traffic over TCP and UDP port 445
iptables -A INPUT -p tcp --dport 445 -j DROP
iptables -A INPUT -p udp --dport 445 -j DROP

# Drop all other incoming traffic
iptables -A INPUT -j DROP

# Save the iptables rules
iptables-save > /etc/iptables/rules.v4
