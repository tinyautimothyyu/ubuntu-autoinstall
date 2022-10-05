#!/bin//bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

# initial setup
/bin/bash scripts/init.sh

# move /home/wheel
/bin/bash scripts/move_wheel.sh

# set up NIS
/bin/bash scripts/nis_setup.sh

# disable swap
echo
echo disabling swap
echo
sed -i.bak -E 's/^\/swapfile.*/\# \/swapfile                                 none            swap    sw              0       0/g' /etc/fstab

# set up time synchronization
/bin/bash scripts/chrony.sh

# enable outgoing email
/bin/bash scripts/enable_email.sh

# install missing packages
/bin/bash scripts/packages_install.sh

# install docker
/bin/bash scripts/install_docker.sh

# install singularity container
/bin/bash scripts/install_singularioty.sh

# build ROOT
/bin/bash scripts/root.sh

# enable automatic updates
/bin/bash scripts/autoupdates.sh

# IPMI instructions
/bin/bash scripts/ipmi.sh

# configuring lightdm
/bin/bash scripts/lightdm.sh

# install google chrome
/bin/bash scripts/googlechrome.sh

# install amanda client
/bin/bash scripts/amanda.sh

# enable rc.local
/bin/bash scripts/rc_local.sh

# disable unwanted services
systemctl disable mpd
systemctl disable snapd
systemctl disable ModemManager

# configure TRIUMF printers
/bin/bash scripts/printers.sh

# enable core dump
/bin/bash scripts/core_dump.sh

# enable debugger
/bin/bash scripts/enable_debugger.sh

# Configure GRUB boot loader
/bin/bash scripts/grub_config.sh

# Updates packages
apt-get update && apt-get dist-upgrade -y && apt-get autoremove -y

# reboot
shutdown -r now

