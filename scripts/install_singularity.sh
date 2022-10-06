#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo
echo installing singularity
echo

# Installation instructions from: https://github.com/sylabs/singularity/blob/main/INSTALL.md
# Singularity Releases: https://github.com/sylabs/singularity/releases

apt-get update

# Install necessary packages
apt-get install -y \
    build-essential \
    libseccomp-dev \
    libglib2.0-dev \
    pkg-config \
    squashfs-tools \
    cryptsetup \
    runc

# Install Go
cd ~root
wget https://go.dev/dl/go1.19.2.linux-amd64.tar.gz
tar -C /usr/local/ -xzvf go1.19.2.linux-amd64.tar.gz
echo 'export GOPATH=${HOME}/go' >> ~/.bashrc && echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc && source ~/.bashrc

# Install Singularity
mkdir -p $GOPATH/src/github.com/sylabs && \
cd $GOPATH/src/github.com/sylabs && \
wget https://github.com/sylabs/singularity/releases/download/v3.10.3/singularity-ce-3.10.3.tar.gz
tar -xzvf singularity-ce-3.10.3.tar.gz
cd ./singularity && \
./mconfig && \
make -C builddir && \
make -C builddir install

# Source bash completion file
#To enjoy bash completion with Singularity commands and options, 
# source the bash completion file like so. 
# Add this command to your ~/.bashrc file so that bash completion continues to work in new shells. 
# (Obviously adjust this path if you installed the bash completion file in a different location.)

# . /usr/local/etc/bash_completion.d/singularity