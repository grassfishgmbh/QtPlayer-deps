#!/bin/bash

source ../config.sh

if [ -e qbs ]; then
    echo "removing existing qbs directory"
    rm -rf qbs
fi

git clone git://code.qt.io/qt-labs/qbs.git
cd qbs
git checkout tags/v${QBS_VERSION}
qmake PREFIX=$INSTALL_PREFIX QBS_INSTALL_PREFIX=$INSTALL_PREFIX -r qbs.pro
make -j`nproc`
sudo make install
