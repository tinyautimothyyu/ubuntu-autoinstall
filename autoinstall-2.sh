#!/bin//bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"


# enable automatic updates
/bin/bash ~root/git/ubuntu-autoinstall/scripts/autoupdates.sh 2>&1 | tee ~root/debug_files/debug_autoupdates.txt

"""
Currently there is a bug with ipmi
"""
# IPMI instructions
# /bin/bash ~root/git/ubuntu-autoinstall/scripts/ipmi.sh

# move /home/wheel
/bin/bash ~root/git/ubuntu-autoinstall/scripts/move_wheel.sh 2>&1 | tee ~root/debug_files/debug_move_wheel.txt

# set up NIS
/bin/bash ~root/git/ubuntu-autoinstall/scripts/nis_setup.sh 2>&1 | tee ~root/debug_files/debug_nis_setup.txt

# install google chrome
/bin/bash ~root/git/ubuntu-autoinstall/scripts/googlechrome.sh 2>&1 | tee ~root/debug_files/debug_googlechrome.txt

# install amanda client
/bin/bash ~root/git/ubuntu-autoinstall/scripts/amanda.sh 2>&1 | tee ~root/debug_files/debug_amanda.txt

# enable rc.local
/bin/bash ~root/git/ubuntu-autoinstall/scripts/rc_local.sh 2>&1 | tee ~root/debug_files/debug_rc_local.txt

# disable unwanted services
systemctl disable mpd
systemctl disable snapd
systemctl disable ModemManager

# configure TRIUMF printers
/bin/bash ~root/git/ubuntu-autoinstall/scripts/printers.sh 2>&1 | tee ~root/debug_files/debug_printers.txt

# enable core dump
/bin/bash ~root/git/ubuntu-autoinstall/scripts/core_dump.sh 2>&1 | tee ~root/debug_files/debug_core_dump.txt

# enable debugger
/bin/bash ~root/git/ubuntu-autoinstall/scripts/enable_debugger.sh 2>&1 | tee ~root/debug_files/debug_enable_debugger.txt

# Updates packages
apt-get update && apt-get dist-upgrade -y && apt-get autoremove -y 

# lightdm seems to not working
# configuring lightdm
# /bin/bash ~root/git/ubuntu-autoinstall/scripts/lightdm.sh

# reboot
shutdown -r now

