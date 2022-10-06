#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo
echo installing kubuntu desktop environment
echo

apt update && apt upgrade -y
apt -y install kubuntu-desktop

echo