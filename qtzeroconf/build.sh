#!/bin/bash

source ../config.sh

set -e

cd $QTZEROCONF_TARGET

if [ -d build ]; then
    rm -rf build
fi
mkdir build

cd build
qmake PREFIX=$INSTALL_PREFIX ..
make -j`nproc`
sudo make install
