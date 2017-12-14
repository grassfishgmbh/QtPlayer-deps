#!/bin/bash

set -e
BASEDIR=$(dirname "$0")
source $BASEDIR/../config.sh
cd $BASEDIR

export PATH=${INSTALL_PREFIX}/bin:${PATH}
export LD_LIBRARY_PATH=${QT_DIR}/lib:$LD_LIBRARY_PATH

if [ ! -d build ]; then
    mkdir build
fi
cd build
cmake ../src -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX}
make -j`nproc`
sudo make install
