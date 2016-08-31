#!/bin/bash

set -e

BASEDIR=$(dirname "$0")

source $BASEDIR/../../config.sh

ZIPTARGET=`pwd`/../..

# zip archive for dev usage
QT_DIR_CYG=`cygpath -a $QT_DIR_WIN`
cp $OSSL_PREFIX/bin/*.dll $QT_DIR_CYG/bin
cd $QT_DIR_CYG/../..
zip -y --symlinks -r Qt-$QT_VERSION.zip $QT_VERSION
mv Qt-$QT_VERSION.zip $ZIPTARGET

