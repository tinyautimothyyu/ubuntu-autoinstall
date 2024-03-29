#!/bin/bash

while getopts h: flag
do
    case "${flag}" in
        h) hostname=${OPTARG};;
    esac
done

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo ####################################
echo
echo installing pre-requisites
apt-get update && apt-get -y upgrade
# while read -r p ; do sudo apt-get install -y $p ; done < <(cat << "EOF"
#     ssh
#     rpcbind nis
#     git
#     autofs
#     vim
# EOF
# )
apt update && apt -y upgrade

apt -y install ssh vim

echo

echo ####################################
echo
echo setting root password
echo -e "root\nroot" | passwd
# passwd
echo

echo ####################################
echo
echo allowing Root login by editing /etc/ssh/sshd_config
sed -i.bak "s/#PermitRootLogin prohibit-password/PermitRootLogin without-password/g" /etc/ssh/sshd_config
sed -i.bak "s/#PasswordAuthentication yes/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sed -i.bak "s/#LogLevel INFO/LogLevel VERBOSE/g" /etc/ssh/sshd_config
systemctl restart sshd
echo

echo ####################################
echo
echo configuring the hostname
echo -n $hostname > /etc/hostname
echo

hostname

echo ####################################
echo
echo pulling scripts from GitHub
mkdir -p ~root/git

cd ~root/git

if cd ~root/git/scripts; then git pull; else git clone https://daq00.triumf.ca/~olchansk/git/scripts.git; fi
cd ~root/git/scripts
git pull
mkdir -p ~root/.ssh
/bin/cp ~root/git/ubuntu-autoinstall/etc/authorized_keys ~root/.ssh/
echo


echo ####################################
echo
echo enabling smart status
ln -sf ~/git/scripts/smart-status/smart-status.perl ~root/
echo

echo ####################################
echo
echo disable sleep and suspend
systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target systemd-suspend.service systemd-hybrid-sleep.service
echo