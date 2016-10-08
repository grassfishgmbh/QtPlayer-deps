#!/bin/bash

set -e

BASEDIR=$(dirname "$0")

source $BASEDIR/../config.sh

if [[ -z "$OPENSSL_VERSION" ]]; then
	echo "OPENSSL_VERSION not set";
    exit -1
fi

cd openssl-$OPENSSL_VERSION

./Configure enable-shared linux-x86_64 --prefix=$QT_DIR
unset MAKEFLAGS
unset CXXFLAGS
make -j`nproc`
sudo make install
