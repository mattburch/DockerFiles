#!/bin/bash

cd ~/
# Do an initial git clone if /proxmark3/git doesn't contain a git repo
[ ! -d proxmark3 ] && git clone https://github.com/Proxmark/proxmark3.git

# Cleanup source dir and pull latest
cd proxmark3
make clean
git pull -u origin master

# Set Build Environment
sed -i 's/\$(shell uname -m)/armv7l/' client/Makefile

# Build
make client

# Create tarball
GIT_VERSION=`git rev-parse --short HEAD`
make tarbin
mv ~/proxmark3/proxmark3-Linux-bin.tar /src
echo -ne "\n\nBinaries will be locaed in /src\n\n"
