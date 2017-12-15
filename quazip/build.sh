#!/bin/bash

set -e
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $BASEDIR
source $BASEDIR/../config.sh

if [ -e build ]; then
    rm -rf build
fi
mkdir build
cd build

qmake ../src/quazip PREFIX=$INSTALL_PREFIX CONFIG+=debug_and_release

make -j`nproc`
sudo cp -r libquazip.so* $INSTALL_PREFIX/lib/
cd ..
sudo mkdir -p $INSTALL_PREFIX/include/quazip
sudo cp *.h $INSTALL_PREFIX/include/quazip/
