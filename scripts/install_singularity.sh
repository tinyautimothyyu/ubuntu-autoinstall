#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo
echo installing singularity
echo

# Installation instructions from: https://docs.sylabs.io/guides/3.0/user-guide/installation.html

# Use the dropdown menus to find the best mirror for your operating system and location. 
# For example, after selecting Ubuntu 22.04 and selecting a mirror in CA, 
# you are instructed to add these lists:

wget -O- http://neuro.debian.net/lists/xenial.us-ca.full | tee /etc/apt/sources.list.d/neurodebian.sources.list && \
    apt-key adv --recv-keys --keyserver hkp://pool.sks-keyservers.net:80 0xA5D32F012649A5A9 && \
    apt-get update

apt-get install -y singularity-container