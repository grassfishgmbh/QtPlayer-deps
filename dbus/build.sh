#!/bin/bash
set -e
BASEDIR=$(dirname "$0")

source $BASEDIR/../config.sh

cd $BASEDIR/src
./autogen.sh --no-configure
./configure --prefix=$INSTALL_PREFIX --disable-doxygen-docs --disable-xml-docs --disable-static --disable-systemd --localstatedir=/var
make -j`nproc`
sudo make install
