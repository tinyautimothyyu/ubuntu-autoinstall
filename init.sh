#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo installing pre-requisites

apt-get update && apt-get -y upgrade

while read -r p ; do sudo apt-get install -y $p ; done < <(cat << "EOF"
    ssh
    rpcbind nis
    git
    autofs
EOF
)

echo setting root password
echo -e "jes+3veTHA\njes+3veTHA" | passwd

echo allowing Root login by editing /etc/ssh/sshd_config
sed -i.bak "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
systemctl restart sshd

echo pulling scripts from GitHub
mkdir ~root/git
cd ~root/git
git clone https://daq00.triumf.ca/~olchansk/git/scripts.git
cd scripts
git pull
/bin/cp ~root/git/scripts/etc/authorized_keys ~root/.ssh/

echo enabling smart status
ln -s ~/git/scripts/smart-status/smart-status.perl ~root/

echo disable sleep and suspend

systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target systemd-suspend.service systemd-hybrid-sleep.service