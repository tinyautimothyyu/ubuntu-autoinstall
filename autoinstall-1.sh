#!/bin//bin/bash

while getopts h: flag
do
    case "${flag}" in
        h) hostname=${OPTARG};;
    esac
done

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

# make a folder to store all the debug files
mkdir -p ~root/debug_files

# initial setup
/bin/bash ~root/git/ubuntu-autoinstall/scripts/init.sh -h $hostname 2>&1 | tee ~root/debug_files/debug_init.txt

# disable swap
echo
echo disabling swap
echo
sed -i.bak -E 's/^\/swapfile.*/\# \/swapfile                                 none            swap    sw              0       0/g' /etc/fstab

# set up time synchronization
/bin/bash ~root/git/ubuntu-autoinstall/scripts/chrony.sh 2>&1 | tee ~root/debug_files/debug_chrony.txt

# enable outgoing email
/bin/bash ~root/git/ubuntu-autoinstall/scripts/enable_email.sh 2>&1 | tee ~root/debug_files/debug_enable_email.txt

# install missing packages
/bin/bash ~root/git/ubuntu-autoinstall/scripts/packages_install.sh 2>&1 | tee ~root/debug_files/debug_packages_install.txt

# configure dns
/bin/bash ~root/git/ubuntu-autoinstall/scripts/dns_config.sh 2>&1 | tee ~root/debug_files/debug_dns_config.txt

# install docker
/bin/bash ~root/git/ubuntu-autoinstall/scripts/install_docker.sh 2>&1 | tee ~root/debug_files/debug_install_docker.txt

# install singularity container
/bin/bash ~root/git/ubuntu-autoinstall/scripts/install_singularity.sh 2>&1 | tee ~root/debug_files/debug_install_singularity.txt

# build ROOT
/bin/bash ~root/git/ubuntu-autoinstall/scripts/root.sh 2>&1 | tee ~root/debug_files/debug_root.txt

# Configure GRUB boot loader
/bin/bash ~root/git/ubuntu-autoinstall/scripts/grub_config.sh 2>&1 | tee ~root/debug_files/debug_grub_config.txt

# reboot
shutdown -r now