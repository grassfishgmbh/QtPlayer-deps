#!/bin/bash

set -e

BASEDIR=$(dirname "$0")

source $BASEDIR/../config.sh

cd $PROTOBUF_SRC_DIR

./configure --prefix=$INSTALL_PREFIX --disable-shared

make -j`nproc` CXXFLAGS=-D_GLIBCXX_USE_CXX11_ABI=0
sudo make install
