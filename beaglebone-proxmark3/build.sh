#!/bin/bash

# Cleanup source dir and pull latest
cd $DEVKITPRO
make clean

# Set Build Environment
sed -i 's/\$(shell uname -m)/armv7l/' client/Makefile

# Build
make

# Create tarball
make tarbin
mv $DEVKITPRO/proxmark3-Linux-bin.tar.gz /src
echo -ne "\n\nBinaries will be locaed in /src\n\n"
