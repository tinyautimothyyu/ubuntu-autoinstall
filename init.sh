#!/bin/bash

while getopts h flag
do
    case "${flag}" in
        h) hostname=${OPTARG};;
    esac
done

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo ####################################
echo
echo installing pre-requisites
apt-get update && apt-get -y upgrade
while read -r p ; do sudo apt-get install -y $p ; done < <(cat << "EOF"
    ssh
    rpcbind nis
    git
    autofs
    vim
EOF
)
echo

echo ####################################
echo
echo setting root password
echo -e "jes+3veTHA\njes+3veTHA" | passwd
echo

echo ####################################
echo
echo allowing Root login by editing /etc/ssh/sshd_config
sed -i.bak "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
sed -i.bak "s/#PasswordAuthentication yes/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sed -i.bak "s/#LogLevel INFO/LogLevel VERBOSE/g" /etc/ssh/sshd_config
systemctl restart sshd
echo

echo ####################################
echo
echo configuring the hostname
echo -n $hostname > /etc/hostname
echo

echo ####################################
echo
echo pulling scripts from GitHub
mkdir -p ~root/git
cd ~root/git
git clone https://daq00.triumf.ca/~olchansk/git/scripts.git
cd scripts
git pull
mkdir -p ~root/.ssh
/bin/cp ~root/git/ubuntu-autoinstall/etc/authorized_keys ~root/.ssh/
echo


echo ####################################
echo
echo enabling smart status
ln -s ~/git/scripts/smart-status/smart-status.perl ~root/
echo

echo ####################################
echo
echo disable sleep and suspend
systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target systemd-suspend.service systemd-hybrid-sleep.service
echo