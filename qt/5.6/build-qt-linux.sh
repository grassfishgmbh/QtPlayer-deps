#!/bin/bash

set -e

BASEDIR=$(dirname "$0")

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

bash $BASEDIR/prepare.sh
bash $BASEDIR/fetch.sh
bash $BASEDIR/build.sh
