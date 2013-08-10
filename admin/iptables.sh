#!/bin/sh

IPT="/sbin/iptables"

if [ ! -x ${IPT} ]; then
	echo "Can't find ${IPT}"
	exit 1
fi

# delete everything
$IPT --flush
$IPT -X TCP
$IPT -X UDP

# add new chains
$IPT -N TCP
$IPT -N UDP

# drop everything going in by default
$IPT -P INPUT DROP
$IPT -P FORWARD DROP
# allow everything out
$IPT -P OUTPUT ACCEPT

# allow established connections
$IPT -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# allow loopback traffic
$IPT -A INPUT -i lo -j ACCEPT

# drop invalid packets
$IPT -A INPUT -m conntrack --ctstate INVALID -j DROP

$IPT -A INPUT -p icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT

$IPT -A INPUT -p udp -m conntrack --ctstate NEW -j UDP
$IPT -A INPUT -p tcp --syn -m conntrack --ctstate NEW -j TCP

$IPT -A INPUT -p udp -j REJECT --reject-with icmp-port-unreachable
$IPT -A INPUT -p tcp -j REJECT --reject-with tcp-rst

$IPT -A INPUT -j REJECT --reject-with icmp-proto-unreachable

$IPT -A TCP -p tcp --dport http -j ACCEPT
$IPT -A TCP -p tcp --dport https -j ACCEPT
