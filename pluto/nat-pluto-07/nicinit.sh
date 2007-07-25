#!/bin/sh

ifconfig eth0:1 inet 192.1.2.245 netmask 255.255.255.0

# NAT North's IP to ours
iptables -t nat -F POSTROUTING 
iptables -t nat -A POSTROUTING --source 192.1.3.0/24 --destination 0.0.0.0/0 -p udp -m udp --dport 500 -j SNAT --to-source 192.1.2.254:11000-12000
iptables -t nat -A POSTROUTING --source 192.1.3.0/24 --destination 0.0.0.0/0 -p udp -m udp --dport 4500 -j SNAT --to-source 192.1.2.245:14000-16000

# Display the table, so we know it's correct.
iptables -t nat -L

echo done.
