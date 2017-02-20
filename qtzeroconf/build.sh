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

sudo mkdir -p ${INSTALL_PREFIX}/include/QtZeroConf
sudo mkdir -p ${INSTALL_PREFIX}/lib

if [ "$GF_BUILD_OS" == "android" ]; then
    sudo cp -v ./libQtZeroConf.so ${INSTALL_PREFIX}/lib
else
    sudo make install
fi

sudo cp -v ../qzeroconf.h ${INSTALL_PREFIX}/include/QtZeroConf/
echo '#include "qzeroconf.h"' | sudo tee ${INSTALL_PREFIX}/include/QtZeroConf/QtZeroConf.h
