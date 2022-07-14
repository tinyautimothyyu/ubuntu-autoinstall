#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo installing amanda client

apt install -y amanda-client

echo setting up amanda client

# edit /etc/amandahosts