#!/bin/bash

source ../config.sh

cd $DBUS_SRC_DIR
./configure --prefix=$INSTALL_PREFIX --disable-doxygen-docs --disable-xml-docs --disable-static --disable-systemd
make -j`nproc`
sudo make install
