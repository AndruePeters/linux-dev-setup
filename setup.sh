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


# first step is to upgrade machine to debian testing
# write testing stuff to /etc/apt/sources.list
sources="deb http://ftp.us.debian.org/debian/ testing main\n
deb-src http://ftp.us.debian.org/debian/ testing main\n
deb http://security.debian.org/debian-security testing/updates main\n
deb-src http://security.debian.org/debian-security testing/updates main\n
deb http://ftp.us.debian.org/debian/ testing-updates main\n
deb-src http://ftp.us.debian.org/debian/ testing-updates main"

dest="./test.txt"
echo -e $sources > $dest

# upgrade machine
apt update && upgrade && dist-upgrade

# install sudo and add user to sudo group
apt install sudo
adduser "$1" sudo

# install packages for development
apt install build-essential cmake git

# install atom
apt install git gconf2 gconf-service libgtk2.0-0 libudev1 libgcrypt20 libnotify4 libxtst6 libnss3 python gvfs-bin xdg-utils libcap2
wget https://github.com/atom/atom/releases/download/v1.38.2/atom-amd64.deb -O atom.deb
dpkg -i atom.deb

# install cross-platform stuff I need for the Raspberry Pi
apt install gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf
dpkg --add-architecture armhf
apt update
apt install libsfml-dev:armhf libncurses-dev:armhf
