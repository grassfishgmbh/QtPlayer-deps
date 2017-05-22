#!/bin/bash

source ../config.sh

if [ -d $LIRIOSWAYLAND_TARGET ]; then
    sudo rm -rf $LIRIOSWAYLAND_TARGET
fi
if [ -d $LIRIOSWAYLAND_SRC_DIR ]; then
    sudo rm -rf $LIRIOSWAYLAND_SRC_DIR
fi

git clone --recursive https://github.com/lirios/wayland buildspace
cd $LIRIOSWAYLAND_TARGET
git checkout $LIRIOSWAYLAND_VERSION

cp -r $LIRIOSWAYLAND_TARGET $LIRIOSWAYLAND_SRC_DIR

echo "src fetch successful"
exit 0
