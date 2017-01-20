#!/bin/bash

set -e

BASEDIR=$(dirname "$0")
ZIPTARGET=$BASEDIR/../..
OLD_PWD_AS_TARGET=`pwd`

source $BASEDIR/../../config.sh

# zip archive for dev usage
QT_DIR_CYG=`cygpath -a $QT_DIR_WIN`
OSSL_PREFIX_CYG=`cygpath -a $OSSL_PREFIX`
#cp $OSSL_PREFIX_CYG/bin/*.dll $QT_DIR_CYG/bin/
cd $QT_DIR_CYG/../..

echo "Moving Qt-$QT_VERSION.zip to $ZIPTARGET"
zip -y --symlinks -r Qt-$QT_VERSION.zip $QT_VERSION

mv Qt-$QT_VERSION.zip $ZIPTARGET/

echo $BUILD_VERSION > $ZIPTARGET/version.txt
md5sum $ZIPTARGET/Qt-$QT_VERSION.zip > $ZIPTARGET/qtframework.txt

