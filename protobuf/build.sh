#!/bin/bash

set -e
BASEDIR=$(dirname "$0")
source $BASEDIR/../config.sh
cd $BASEDIR

cd src
export CXXFLAGS="$CXXFLAGS -fPIC"
./autogen.sh
./configure --prefix=$INSTALL_PREFIX --enable-shared

make -j`nproc` CXXFLAGS=-D_GLIBCXX_USE_CXX11_ABI=0
sudo make install
