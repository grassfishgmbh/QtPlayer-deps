#!/bin/bash

set -e
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $BASEDIR
source $BASEDIR/../config.sh

if [ -d build ]; then
    rm -rf build
fi
mkdir build

cd build
qmake PREFIX=$INSTALL_PREFIX ../src
make -j`nproc`

sudo mkdir -p ${INSTALL_PREFIX}/include/QtZeroConf
sudo mkdir -p ${INSTALL_PREFIX}/lib

if [ "$GF_BUILD_OS" == "android" ]; then
    sudo cp -v ./libQtZeroConf.so ${INSTALL_PREFIX}/lib
else
    sudo make install
fi

sudo cp -v ../qzeroconf.h ${INSTALL_PREFIX}/include/QtZeroConf/
sudo sed -i "s/signals/Q_SIGNALS/g" ${INSTALL_PREFIX}/include/QtZeroConf/qzeroconf.h
sudo sed -i "s/slots/Q_SLOTS/g" ${INSTALL_PREFIX}/include/QtZeroConf/qzeroconf.h

