#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

# IPMI is the board management hardware on Supermicro and other server motherboards. 
# This includes hardware sensors - fan rotation speed, temperatures and power supply voltages.

echo
echo installing ipmitool
echo

apt-get install -y ipmitool
systemctl enable ipmievd
systemctl restart ipmievd