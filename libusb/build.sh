#!/bin/bash

source ../config.sh

cd $LIBUSB_SRC_DIR
./configure --prefix=$INSTALL_PREFIX
make -j`nproc`
sudo make install
