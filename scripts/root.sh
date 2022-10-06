#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo
echo building ROOT 
echo

cd ~

apt -y install libx11-dev libxpm-dev libxft-dev libxext-dev libpng-dev libjpeg-dev xlibmesa-glu-dev libxml2-dev libgsl-dev cmake

wget https://root.cern/download/root_v6.26.06.Linux-ubuntu22-x86_64-gcc11.2.tar.gz

tar -xzvf root_v6.26.06.Linux-ubuntu22-x86_64-gcc11.2.tar.gz

source ~root/root/bin/thisroot.sh

echo 'source ~root/root/bin/thisroot.sh' >> ~/.bashrc

source ~/.bashrc