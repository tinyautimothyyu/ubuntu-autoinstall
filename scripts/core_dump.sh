#!/bin/bash

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

apt remove -y apport
apt autoremove -y ### will remove apport-symptoms and a few other packages
