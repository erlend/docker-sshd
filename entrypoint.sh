#!/bin/sh

if [ `basename $1` = "sshd" ]; then
  for key in rsa dsa ecdsa ed25519; do
    [ -f /etc/ssh/ssh_host_${key}_key ] || ssh-keygen -A
  done
fi

exec dumb-init $@
