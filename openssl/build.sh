#!/bin/bash

set -e
BASEDIR=$(dirname "$0")
source $BASEDIR/../config.sh
cd $BASEDIR

cd src
if [ "$1" == "qt" ]; then
    ./Configure enable-shared linux-x86_64 --prefix=$QT_DIR
else
    ./Configure enable-shared linux-x86_64 --prefix=$INSTALL_PREFIX
fi
unset MAKEFLAGS
unset CXXFLAGS
make -j`nproc`
sudo make install
