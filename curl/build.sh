#!/bin/bash

set -e

BASEDIR=$(dirname "$0")

source $BASEDIR/../config.sh

cd $CURL_TARGET/curl-$CURL_VERSION

export PKG_CONFIG_PATH=$INSTALL_PREFIX/lib/pkgconfig

./configure \
  	--with-random=/dev/urandom \
	--prefix=$INSTALL_PREFIX \
	--mandir=$INSTALL_PREFIX/share/man \
	--disable-dependency-tracking \
	--enable-ipv6 \
	--disable-ldaps \
	--disable-ldap \
	--enable-manual \
	--enable-versioned-symbols \
	--with-ca-path=/etc/ssl/certs \
	--without-libidn \
	--with-ssl \
	--without-libssh2

make -j`nproc`
sudo make install
