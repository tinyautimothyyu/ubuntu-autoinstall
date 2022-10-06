#!/bin/bash

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo
echo enabling outgoing email
echo

apt-get install -y postfix
apt-get install -y mailutils
# echo tyu@triumf.ca t2kcompute@comp.nd280.org >> ~root/.forward
echo tyu@triumf.ca lindner@triumf.ca >> ~root/.forward