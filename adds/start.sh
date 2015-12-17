#!/bin/bash

# setup time zone
DTIMEZONE=${DTIMEZONE:-Europe/Berlin}
ln -sf /usr/share/zoneinfo/${DTIMEZONE} /etc/localtime

# setup user
DUSERNAME="${DUSERNAME:-oe}"
DUSERID="${DUSERID:-1000}"
DGROUPNAME="${DGROUPNAME:-oe}"
DGROUPID="${DGROUPID:-1000}"
DPASSWD="${DPASSWD:-oe}"
useradd -d /home/${DUSERNAME} -U -G sudo -m -s /bin/bash -u ${DUSERID} ${DUSERNAME}
echo "${DUSERNAME}:${DPASSWD}" | chpasswd
echo "%sudo   ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/sudogrp


# give ip-address
ip addr show eth0

mkdir /var/run/sshd
/usr/sbin/sshd -D
