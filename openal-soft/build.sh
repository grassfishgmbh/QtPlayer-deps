#!/bin/bash

source ../config.sh
export PATH=${INSTALL_PREFIX}/bin:${PATH}
export LD_LIBRARY_PATH=${QT_DIR}/lib:$LD_LIBRARY_PATH

set -e

cd $OPENALSOFT_TARGET

if [ ! -d build ]; then
    mkdir build
fi
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX}
make -j4
sudo make install
