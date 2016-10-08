#!/bin/bash

set -e

BASEDIR=$(dirname "$0")

source $BASEDIR/../config.sh

cd $ZLIB_SRC_DIR

export PKG_CONFIG_PATH=$INSTALL_PREFIX/lib/pkgconfig

./configure \
  	--with-random=/dev/urandom \
	--prefix=$INSTALL_PREFIX \
	--mandir=/share/man \
	--disable-dependency-tracking \
	--enable-ipv6 \
	--disable-ldaps \
	--disable-ldap \
	--enable-manual \
	--enable-versioned-symbols \
	--with-ca-path=/etc/ssl/certs \
	--without-libidn \
	--with-ssl

make -j`nproc`
sudo make install