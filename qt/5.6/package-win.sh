#!/bin/bash

set -e

BASEDIR=$(dirname "$0")
ZIPTARGET=$BASEDIR/../..

source $BASEDIR/../../config.sh

# zip archive for dev usage
QT_DIR_CYG=`cygpath -a $QT_DIR_WIN`
cp $OSSL_PREFIX/bin/*.dll $QT_DIR_CYG/bin
cd $QT_DIR_CYG/../..

echo "Moving Qt-$QT_VERSION.zip to $ZIPTARGET"
zip -y --symlinks -r Qt-$QT_VERSION.zip $QT_VERSION

mv Qt-$QT_VERSION.zip $ZIPTARGET

echo $BUILD_VERSION > $ZIPTARGET/version.txt
md5sum $ZIPTARGET/Qt-$QT_VERSION.zip > $ZIPTARGET/qtframework.txt

