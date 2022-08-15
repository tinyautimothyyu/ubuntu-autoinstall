#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

# initial setup
source init.sh

# move /home/wheel
source move_wheel.sh

# set up NIS
source nis_setup.sh

# disable swap
echo
echo disabling swap
echo
sed -i.bak -E 's/^\/swapfile.*/\# \/swapfile                                 none            swap    sw              0       0/g' /etc/fstab

# set up time synchronization
source chrony.sh

# enable outgoing email
source enable_email.sh

# install missing packages
source packages_install.sh

# build ROOT
source root.sh

# enable automatic updates
source autoupdates.sh

# IPMI instructions
source ipmi.sh

# configuring lightdm
source lightdm.sh

# install google chrome
source googlechrome.sh

# install amanda client
source amanda.sh

# enable rc.local
source rc_local.sh

# disable unwanted services
systemctl disable mpd
systemctl disable snapd
systemctl disable ModemManager

# configure TRIUMF printers
source printers.sh

# enable core dump
source core_dump.sh

# enable debugger
source enable_debugger.sh

# Configure GRUB boot loader
source grub_config.sh

# Updates packages
apt-get update && apt-get dist-upgrade -y && apt-get autoremove -y

# reboot
shutdown -r now

