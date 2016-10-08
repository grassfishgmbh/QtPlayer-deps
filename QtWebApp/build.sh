#!/bin/bash

set -e

BASEDIR=$(dirname "$0")

source $BASEDIR/../config.sh

if [ -e build ]; then
    rm -rf build
fi
mkdir build
cd build

qmake ../QtWebApp.pro PREFIX=$INSTALL_PREFIX CONFIG+=debug_and_release

make -j`nproc`
sudo cp -r libQtWebApp.so* $INSTALL_PREFIX/lib/
cd ..
sudo mkdir -p $INSTALL_PREFIX/include/QtWebApp/httpserver
sudo cp -r httpserver/*.h $INSTALL_PREFIX/include/QtWebApp/httpserver
