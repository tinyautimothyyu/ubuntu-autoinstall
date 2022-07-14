#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo enabling rc.local

cd ~/git/scripts
cp etc/rc.local /etc/
chmod a+rx /etc/rc.local
cp etc/rc-local.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable rc-local
systemctl start rc-local
systemctl status rc-local