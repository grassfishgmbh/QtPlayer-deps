#!/bin/bash

set -e

BASEDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

source $BASEDIR/../../config.sh

if [[ -z "$QT_VERSION" ]]; then
	echo "QT_VERSION not set";
    exit -1
fi

if [[ -z "$BUILD_VERSION" ]]; then
	echo "BUILD_VERSION string not set";
    exit -1
fi


rm -f *.zip
rm -rf qt-src
rm -f *.txt

cd $CONFIG_DIR/openssl
bash fetch.sh
bash build.sh qt

cd $BASEDIR

bash $BASEDIR/prepare.sh
bash $BASEDIR/fetch.sh
bash $BASEDIR/build.sh
