#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo
echo enable automatic updates
echo

apt -y install unattended-upgrades

# uncomment in Allowed-Origins "-updates"
sed -i.bak -E 's/^\/\/\s+\"\$\{distro_id\}\:\$\{distro_codename\}-updates\"\;/        \"\$\{distro_id\}\:\$\{distro_codename\}-updates\"\;/g' /etc/apt/apt.conf.d/50unattended-upgrades

# add in Allowed-Origins: "Google LLC:stable";
sed -i.bak -E 's/^\/\/\s+\"\$\{distro_id\}\:\$\{distro_codename\}-backports\"\;/&\n        "Google LLC:stable";/g' /etc/apt/apt.conf.d/50unattended-upgrades

# uncomment/add: "Unattended-Upgrade::Mail "root";
sed -i.bak 's+//Unattended-Upgrade::Mail "";+Unattended-Upgrade::Mail "root";+g' /etc/apt/apt.conf.d/50unattended-upgrades

# updated the periodic update config. file
sed -i.bak 's+APT::Periodic::Download-Upgradeable-Packages "0";+APT::Periodic::Download-Upgradeable-Packages "1";+g' /etc/apt/apt.conf.d/10periodic
sed -i.bak 's+APT::Periodic::AutocleanInterval "0";+APT::Periodic::AutocleanInterval "7";+g' /etc/apt/apt.conf.d/10periodic
echo 'APT::Periodic::Unattended-Upgrade "1";' >> /etc/apt/apt.conf.d/10periodic