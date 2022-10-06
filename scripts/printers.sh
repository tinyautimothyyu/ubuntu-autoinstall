#!/bin/bash

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo
echo configuring TRIUMF printers
echo

systemctl stop cups
systemctl disable cups
echo "ServerName printers.triumf.ca" > /etc/cups/client.conf
lpstat -a

