#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo
echo installing singularity
echo

# Installation instructions from: https://docs.sylabs.io/guides/3.0/user-guide/installation.html

apt-get update && apt-get upgrade -y

# Install necessary packages
apt-get install -y build-essential libssl-dev uuid-dev libgpgme11-dev \
    squashfs-tools libseccomp-dev wget pkg-config git cryptsetup debootstrap

# Install Go
cd ~root
wget https://go.dev/dl/go1.18.4.linux-amd64.tar.gz
tar -C /usr/local/ -xzvf go1.18.4.linux-amd64.tar.gz
echo 'export GOPATH=${HOME}/go' >> ~/.bashrc && echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc &&source ~/.bashrc

# Install Singularity
wget https://github.com/sylabs/singularity/releases/download/v3.10.2/singularity-ce-3.10.2.tar.gz
tar -xzvf singularity-ce-3.10.2.tar.gz
cd singularity
./mconfig
cd  builddir/
make
make install

. etc/bash_completion.d/singularity
cp etc/bash_completion.d/singularity /etc/bash_completion.d/