#!/bin/bash

source ../config.sh

cd $LIBUSB_TARGET
./configure --prefix=$INSTALL_PREFIX
make -j`nproc`
sudo make install
