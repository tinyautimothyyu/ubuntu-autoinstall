#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo ####################################
echo
echo setting up NIS
domainname NEUT-NIS 
echo NEUT-NIS >> /etc/defaultdomain
echo domain NEUT-NIS broadcast >> /etc/yp.conf
sed -i.bak "s/NISSERVER=false/NISSERVER=slave/g" /etc/default/nis
/usr/lib/yp/ypinit -s neutsrv2.triumf.ca 
systemctl enable ypbind
systemctl restart ypbind
systemctl status ypbind
ypwhich -m
ypcat -k passwd
echo

echo ####################################
echo
echo setting up autofs
systemctl enable autofs
echo

echo ####################################
echo
echo editing /etc/nsswitch.conf
if grep '^passwd.*' /etc/nsswitch.conf
then
    sed -i.bak 's/^passwd.*/passwd: files nis/g' /etc/nsswitch.conf
else
    echo 'passwd: files nis' >> /etc/nsswitch.conf
fi

if grep '^group.*' /etc/nsswitch.conf
then
    sed -i.bak 's/^group.*/group: files nis/g' /etc/nsswitch.conf
else
    echo 'group: files nis' >> /etc/nsswitch.conf
fi

if grep '^shadow.*' /etc/nsswitch.conf
then
    sed -i.bak 's/^shadow.*/shadow: files nis/g' /etc/nsswitch.conf
else
    echo 'shadow: files nis' >> /etc/nsswitch.conf
fi

if grep '^automount.*' /etc/nsswitch.conf
then
    sed -i.bak 's/^automount.*/automount: files nis/g' /etc/nsswitch.conf
else
    echo 'automount: files nis' >> /etc/nsswitch.conf
fi

if grep '^netgroup.*' /etc/nsswitch.conf
then
    sed -i.bak 's/^netgroup.*/netgroup: files nis/g' /etc/nsswitch.conf
else
    echo 'netgroup: files nis' >> /etc/nsswitch.conf
fi

systemctl restart autofs
echo

echo ####################################
echo
echo enabling hourly update of NIS maps
cd ~/git/scripts/etc
ln -s $PWD/ypxfr-cron-hourly /etc/cron.hourly
echo