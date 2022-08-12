#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo ####################################
echo
echo moving /home/wheel to /wheel
sed -i.bak 's+wheel:x:1000:1000:,,,:/home/wheel:/bin/bash+wheel:x:80:80:,,,:/wheel:/bin/bash+g' /etc/passwd
echo
