#!/bin/sh
set -euo pipefail 
mkdir /dev/net
mknod /dev/net/tun c 10 200
chmod 600 /dev/net/tun

# Enable NAT forwarding
iptables -t nat -A POSTROUTING -j MASQUERADE -s 10.10.11.0/24
# iptables -A FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu

/ocserv/dist/sbin/ocserv \
  --foreground  \
  --pid-file /run/ocserv.pid \
  --config /ocserv/conf/ocserv.conf

