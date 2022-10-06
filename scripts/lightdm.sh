#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo installing lightdm

apt install -y lightdm

echo enable lightdm

echo lightdm | dpkg-reconfigure -fteletype lightdm
systemctl disable gdm
systemctl disable sddm
systemctl enable lightdm

echo configuring lightdm

systemctl disable gdm
systemctl enable lightdm

cd ~root/git/scripts/

/bin/cp -v etc/lightdm_enable_nis_login.conf /etc/lightdm/lightdm.conf.d/

systemctl stop gdm
systemctl restart lightdm