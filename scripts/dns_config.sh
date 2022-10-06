#!/bin/bash

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo
echo configuring dns
echo

cd ~/git/scripts
git pull
mkdir -p /etc/systemd/resolved.conf.d
cp etc/resolved-triumf.conf /etc/systemd/resolved.conf.d/
systemctl restart systemd-resolved
resolvectl