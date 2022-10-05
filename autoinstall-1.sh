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

# configure dns
/bin/bash ~root/git/ubuntu-autoinstall/scripts/dns_config.sh

# install docker
/bin/bash ~root/git/ubuntu-autoinstall/scripts/install_docker.sh

# install singularity container
/bin/bash ~root/git/ubuntu-autoinstall/scripts/install_singularity.sh

# build ROOT
/bin/bash ~root/git/ubuntu-autoinstall/scripts/root.sh

# Configure GRUB boot loader
/bin/bash ~root/git/ubuntu-autoinstall/scripts/grub_config.sh

# reboot
shutdown -r now