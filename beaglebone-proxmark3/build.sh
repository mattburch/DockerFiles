#!/bin/bash

get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" |\
    grep '"tag_name":' |\
    sed -E 's/.*"([^"]+)".*/\1/'
}

# Do pull latest git release
wget -t 10 https://github.com/Proxmark/proxmark3/archive/`get_latest_release "Proxmark/proxmark3"`.tar.gz -O - |\
    tar zxfv -

# Pull Toolchanin
wget -t 10 https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/8-2018q4/gcc-arm-none-eabi-8-2018-q4-major-linux.tar.bz2 -O - |\
    tar xfvj - -C proxmark*

# Setup Global Variables
cd proxmark3*
export DEVKITPRO=${PWD}
export DEVKITARM=$DEVKITPRO/gcc-arm-none-eabi-8-2018-q4-major
export PATH=${PATH}:${DEVKITARM}/bin


# Cleanup source dir and pull latest
make clean
git pull

# Set Build Environment
sed -i 's/\$(shell uname -m)/armv7l/' client/Makefile

# Build
make client

# Create tarball
GIT_VERSION=`git rev-parse --short HEAD`
make tarbin
mv $DEVKITPRO/proxmark3-Linux-bin.tar.gz /src
echo -ne "\n\nBinaries will be locaed in /src\n\n"
