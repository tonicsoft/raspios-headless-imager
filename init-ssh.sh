#!/bin/sh

set +e

## Enable SSH on first boot
touch /boot/ssh

## Configure user

echo -n "${USER}:" | tee -a /boot/userconf
echo "\""
echo "${PASSWORD}" | openssl passwd -6 -stdin | tee -a /boot/userconf > /dev/null

## Enable passwordless ssh
mkdir -p /home/${USER}/.ssh

chmod 700 /home/${USER}/.ssh
chown ${USER}:${USER} /home/${USER}/.ssh

touch /home/${USER}/.ssh/authorized_keys

echo "${KEY}" | tee -a /home/${USER}/.ssh/authorized_keys

chmod 600 /home/${USER}/.ssh/authorized_keys
chown ${USER}:${USER} /home/${USER}/.ssh/authorized_keys

exit 0