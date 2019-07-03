#!/usr/bin/env bash
# expects to be passed current username
# this is because this script will run on an install that does not yet of sudo
# and then be ran as root

#check if user passed username, exit if not
if [ -z "$1" ]
then
  printf "No username submitted.\nExiting...\n"
  exit 1;
fi

# install these packages first
apt update
apt install -y curl wget apt-transport-https dirmngr

# first step is to upgrade machine to debian testing
# write testing stuff to /etc/apt/sources.list
sources="deb http://deb.debian.org/debian/ testing main\ndeb-src http://deb.debian.org/debian/ testing main\ndeb http://deb.debian.org/debian/ testing-updates main\ndeb-src http://deb.debian.org/debian/ testing-updates main"

dest="/etc/apt/sources.list"
cp /etc/apt/sources.list sources.list.bak_

echo -e $sources > $dest

# upgrade machine
apt update -y; apt upgrade -y; apt dist-upgrade -y

# install tools needed for vmware
apt install -y open-vm-tools open-vm-tools-dekstop

# install sudo and add user to sudo group
apt install -y sudo
adduser "$1" sudo

# install packages for development
apt install -y build-essential cmake git

# install atom
apt install -y git gconf2 gconf-service libgtk2.0-0 libudev1 libgcrypt20 libnotify4 libxtst6 libnss3 python gvfs-bin xdg-utils libcap2
wget https://github.com/atom/atom/releases/download/v1.38.2/atom-amd64.deb -O atom.deb
dpkg -i atom.deb

# install cross-platform stuff I need for the Raspberry Pi
apt install -y gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf
dpkg --add-architecture armhf
apt update
apt install -y libsfml-dev:armhf libncurses-dev:armhf
