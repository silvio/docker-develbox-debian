#!/bin/bash

# setup time zone
DTIMEZONE=${DTIMEZONE:-Europe/Berlin}
ln -sf /usr/share/zoneinfo/${DTIMEZONE} /etc/localtime

# give ip-address
ip addr show eth0

mkdir /var/run/sshd
/usr/sbin/sshd -D
