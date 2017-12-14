#!/bin/bash

set -e
BASEDIR=$(dirname "$0")
source $BASEDIR/../config.sh
cd $BASEDIR/src

NOCONFIGURE=1 ./autogen.sh
./configure --prefix=$INSTALL_PREFIX
make -j`nproc`
sudo make install
