#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo
echo installing missing packages
echo

apt update && apt -y upgrade

apt -y install software-properties-common
add-apt-repository ppa:deadsnakes/ppa  # get PPA to install python3.8
apt -y install ssh tcsh ethtool ncat rsync strace net-tools sysstat smartmontools lm-sensors traceroute time minicom screen git lsof debsums tmux
apt -y install lsb-release
apt -y install flex bison
apt -y install neofetch
apt -y install snmp snmp-mibs-downloader
apt -y install git subversion g++ gfortran cmake doxygen
apt -y install curl libcurl4 libcurl4-openssl-dev
apt -y install mariadb-client ### mysql client
apt -y install libz-dev sqlite3 libsqlite3-dev unixodbc-dev
apt -y install libssl-dev
apt -y install emacs xemacs21 joe
apt -y install gnuplot dos2unix
apt -y install mutt bsd-mailx # email clients
apt -y install liblz4-tool pbzip2
apt -y install libc6-dev-i386 # otherwise no /usr/include/sys/types.h
apt -y install libreadline-dev
apt -y install chromium-browser chromium-codecs-ffmpeg-extra
apt -y install ubuntu-mate-themes
apt -y install libmotif-dev libxmu-dev
apt -y install libusb-dev libusb-1.0-0-dev
apt -y install xfig gsfonts-x11 gsfonts-other # install fonts for xfig
apt -y install libjson-perl
apt -y install libgsl-dev # additional GNU Scientific Library
apt -y install qtcreator qtbase5-dev qt5-qmake # Qt development
apt -y install python3.8-full python3.8-dev python3.8-dbg python3-pip ### for pyROOT
apt -y install imagemagick imagemagick-common ckeditor # for elog
apt -y install linux-tools-common linux-tools-generic # cpupower frequency-info
apt -y install libjpeg-dev libjpeg-progs libjpeg-tools
# apt -y install linux-image-generic-hwe-20.04 linux-tools-virtual-hwe-20.04 # enable linux 5.11 series kernel