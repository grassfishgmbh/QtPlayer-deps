#!/bin/bash

source ../config.sh

cd $LIBUSB_TARGET/libusb-$LIBUSB_VERSION
./configure --prefix=$INSTALL_PREFIX
make -j`nproc`
sudo make install
