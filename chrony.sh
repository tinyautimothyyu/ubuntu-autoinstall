#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo installing chrony

apt-get -y install chrony

echo server time1.triumf.ca iburst >> /etc/chrony/chrony.conf
echo server time2.triumf.ca iburst >> /etc/chrony/chrony.conf
echo server time3.triumf.ca iburst >> /etc/chrony/chrony.conf
systemctl disable systemd-timesyncd.service
systemctl stop systemd-timesyncd.service
systemctl disable ntp
systemctl stop ntp
systemctl enable chrony
systemctl restart chrony
chronyc sources
chronyc tracking