#!/bin//bin/bash

while getopts h flag
do
    case "${flag}" in
        h) hostname=${OPTARG};;
    esac
done

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

# initial setup
/bin/bash ~root/git/ubuntu-autoinstall/scripts/init.sh -h $hostname

# move /home/wheel
/bin/bash ~root/git/ubuntu-autoinstall/scripts/move_wheel.sh

# set up NIS
/bin/bash ~root/git/ubuntu-autoinstall/scripts/nis_setup.sh

# disable swap
echo
echo disabling swap
echo
sed -i.bak -E 's/^\/swapfile.*/\# \/swapfile                                 none            swap    sw              0       0/g' /etc/fstab

# set up time synchronization
/bin/bash ~root/git/ubuntu-autoinstall/scripts/chrony.sh

# enable outgoing email
/bin/bash ~root/git/ubuntu-autoinstall/scripts/enable_email.sh

# install missing packages
/bin/bash ~root/git/ubuntu-autoinstall/scripts/packages_install.sh

# install docker
/bin/bash ~root/git/ubuntu-autoinstall/scripts/install_docker.sh

# install singularity container
/bin/bash ~root/git/ubuntu-autoinstall/scripts/install_singularity.sh

# build ROOT
/bin/bash ~root/git/ubuntu-autoinstall/scripts/root.sh

# enable automatic updates
/bin/bash ~root/git/ubuntu-autoinstall/scripts/autoupdates.sh

# IPMI instructions
/bin/bash ~root/git/ubuntu-autoinstall/scripts/ipmi.sh

# configuring lightdm
/bin/bash ~root/git/ubuntu-autoinstall/scripts/lightdm.sh

# install google chrome
/bin/bash ~root/git/ubuntu-autoinstall/scripts/googlechrome.sh

# install amanda client
/bin/bash ~root/git/ubuntu-autoinstall/scripts/amanda.sh

# enable rc.local
/bin/bash ~root/git/ubuntu-autoinstall/scripts/rc_local.sh

# disable unwanted services
systemctl disable mpd
systemctl disable snapd
systemctl disable ModemManager

# configure TRIUMF printers
/bin/bash ~root/git/ubuntu-autoinstall/scripts/printers.sh

# enable core dump
/bin/bash ~root/git/ubuntu-autoinstall/scripts/core_dump.sh

# enable debugger
/bin/bash ~root/git/ubuntu-autoinstall/scripts/enable_debugger.sh

# Configure GRUB boot loader
/bin/bash ~root/git/ubuntu-autoinstall/scripts/grub_config.sh

# Updates packages
apt-get update && apt-get dist-upgrade -y && apt-get autoremove -y

# reboot
shutdown -r now

