#!/bin//bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"


# enable automatic updates
/bin/bash ~root/git/ubuntu-autoinstall/scripts/autoupdates.sh

# IPMI instructions
/bin/bash ~root/git/ubuntu-autoinstall/scripts/ipmi.sh

# move /home/wheel
/bin/bash ~root/git/ubuntu-autoinstall/scripts/move_wheel.sh

# set up NIS
/bin/bash ~root/git/ubuntu-autoinstall/scripts/nis_setup.sh

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

# Updates packages
apt-get update && apt-get dist-upgrade -y && apt-get autoremove -y

# reboot
shutdown -r now

