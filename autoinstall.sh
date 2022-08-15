#!/bin//bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

# initial setup
/bin/bash init.sh

# move /home/wheel
/bin/bash move_wheel.sh

# set up NIS
/bin/bash nis_setup.sh

# disable swap
echo
echo disabling swap
echo
sed -i.bak -E 's/^\/swapfile.*/\# \/swapfile                                 none            swap    sw              0       0/g' /etc/fstab

# set up time synchronization
/bin/bash chrony.sh

# enable outgoing email
/bin/bash enable_email.sh

# install missing packages
/bin/bash packages_install.sh

# build ROOT
/bin/bash root.sh

# enable automatic updates
/bin/bash autoupdates.sh

# IPMI instructions
/bin/bash ipmi.sh

# configuring lightdm
/bin/bash lightdm.sh

# install google chrome
/bin/bash googlechrome.sh

# install amanda client
/bin/bash amanda.sh

# enable rc.local
/bin/bash rc_local.sh

# disable unwanted services
systemctl disable mpd
systemctl disable snapd
systemctl disable ModemManager

# configure TRIUMF printers
/bin/bash printers.sh

# enable core dump
/bin/bash core_dump.sh

# enable debugger
/bin/bash enable_debugger.sh

# Configure GRUB boot loader
/bin/bash grub_config.sh

# Updates packages
apt-get update && apt-get dist-upgrade -y && apt-get autoremove -y

# reboot
shutdown -r now

