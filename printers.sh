#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo configuring TRIUMF printers

systemctl stop cups
systemctl disable cups
echo "ServerName printers.triumf.ca" > /etc/cups/client.conf
lpstat -a

