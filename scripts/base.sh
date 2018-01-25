#!/bin/bash

apt-get -y -qq update
apt-get -y -qq install linux-headers-$(uname -r) iptables-persistent python

iptables -F
iptables -X
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

iptables-save > /etc/iptables/rules.v4
iptables-save > /etc/iptables/rules.v6
