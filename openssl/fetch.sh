#!/bin/bash

set -e

BASEDIR=$(dirname "$0")

source $BASEDIR/../config.sh

if [[ -z "$OPENSSL_VERSION" ]]; then
	echo "OPENSSL_VERSION not set";
    exit -1
fi

# clean up
sudo rm -f *.zip
sudo rm -f *.tar.gz
if [ -e openssl-$OPENSSL_VERSION ]; then
    sudo rm -rf openssl-$OPENSSL_VERSION
fi

# fetch sources
wget --no-check-certificate https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz
tar xvzf openssl-$OPENSSL_VERSION.tar.gz
mkdir src || true
tar xvzf openssl-$OPENSSL_VERSION.tar.gz -C src/
