#!/bin/bash

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo
echo enabling rc.local
echo

cd ~/git/scripts
cp etc/rc.local /etc/
chmod a+rx /etc/rc.local
cp etc/rc-local.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable rc-local
systemctl start rc-local
systemctl status rc-local