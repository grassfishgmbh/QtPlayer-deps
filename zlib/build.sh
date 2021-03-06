#!/bin/bash

set -e

BASEDIR=$(dirname "$0")

source $BASEDIR/../config.sh

cd $ZLIB_TARGET/zlib-$ZLIB_VERSION

export PKG_CONFIG_PATH=$INSTALL_PREFIX/lib/pkgconfig

./configure \
	--prefix=$INSTALL_PREFIX \
	--eprefix=$INSTALL_PREFIX

make -j`nproc`
sudo make install
