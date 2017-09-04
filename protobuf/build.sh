#!/bin/bash

set -e

BASEDIR=$(dirname "$0")

source $BASEDIR/../config.sh

cd $PROTOBUF_TARGET

export CXXFLAGS="$CXXFLAGS -fPIC"
./configure --prefix=$INSTALL_PREFIX --enable-shared

make -j`nproc` CXXFLAGS=-D_GLIBCXX_USE_CXX11_ABI=0
sudo make install
