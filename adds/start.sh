#!/bin/bash

# give ip-address
ip addr show eth0

mkdir /var/run/sshd
/usr/sbin/sshd -D
