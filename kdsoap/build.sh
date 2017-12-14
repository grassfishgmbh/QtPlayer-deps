#!/bin/bash

set -e

BASEDIR=$(dirname "$0")

source $BASEDIR/../config.sh
cd $BASEDIR
#qmake kdsoap.pro
#./configure.sh -shared -release -prefix $INSTALL_PREFIX
#make -j`nproc`

if [ -d build ]; then
    rm -rf build
fi
mkdir build
cd build
cmake ../src -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX

make -j`nproc`

sudo make install
#sudo cp -a lib/libkdsoap.so* $INSTALL_PREFIX/lib/
#sudo cp -a /usr/local/KDAB/KDSoap-/* $INSTALL_PREFIX/
#sudo rm -rf /usr/local/KDAB/KDSoap-/
