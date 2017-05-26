#!/bin/bash

source ../config.sh

if [ -d $LIBQTXDG_TARGET ]; then
    sudo rm -rf $LIBQTXDG_TARGET
fi
if [ -d $LIBQTXDG_SRC_DIR ]; then
    sudo rm -rf $LIBQTXDG_SRC_DIR
fi

git clone --recursive https://github.com/lxde/libqtxdg buildspace
cd $LIBQTXDG_TARGET
git checkout tags/$LIBQTXDG_VERSION

cp -r $LIBQTXDG_TARGET $LIBQTXDG_SRC_DIR

echo "src fetch successful"
exit 0
