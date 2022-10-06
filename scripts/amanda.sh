#!/bin/bash

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo
echo installing amanda client
echo

apt install -y amanda-client

echo
echo setting up amanda client
echo

echo amanda.triumf.ca amanda amdump > /etc/amandahosts