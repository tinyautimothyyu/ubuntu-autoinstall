#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

# initial setup
source init.sh

# move /home/wheel
source move_wheel.sh

# set up NIS
source nis_setup.sh

# disable swap

# configure hostname

# set up time synchronization
source chrony.sh

# enable outgoing email

# install missing packages
source packages_install.sh

# build ROOT
source root.sh

# enable automatic updates

# IPMI instructions

# configuring lightdm
source lightdm.sh

# install google chrome
source googlechrome.sh

# install amanda client
source amanda.sh

# enable rc.local
source rc_local.sh

# disable unwanted services
systemctl disable mpd
systemctl disable snapd
systemctl disable ModemManager

# enable elog pdf viewer

# configure TRIUMF printers
source printers.sh

# enable debugger

# Configure GRUB boot loader

