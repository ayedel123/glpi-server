#!/bin/bash

set -e

if ! command -v knockd &>/dev/null; then
    apt-get install -y knockd
fi

if ! command -v iptables &>/dev/null; then
    apt-get install -y iptables
fi

cp knockd.conf /etc/
systemctl restart knockd

iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -j DROP

echo "Firewall has been successfully installed"
