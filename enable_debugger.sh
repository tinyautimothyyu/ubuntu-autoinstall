#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo
echo enabling debugger
echo

sed -i.bak -E 's/^\#\!\/bin\/bash/&\necho 0 > \/proc\/sys\/kernel\/yama\/ptrace_scope/g' /etc/rc.local