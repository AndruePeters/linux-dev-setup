#!/usr/bin/env bash

# first step is to upgrade machine to debian testing
sources="deb http://ftp.us.debian.org/debian/ testing main\n
deb-src http://ftp.us.debian.org/debian/ testing main\n
deb http://security.debian.org/debian-security testing/updates main\n
deb-src http://security.debian.org/debian-security testing/updates main\n
deb http://ftp.us.debian.org/debian/ testing-updates main\n
deb-src http://ftp.us.debian.org/debian/ testing-updates main"

dest="./test.txt"
echo -e $sources > $dest
