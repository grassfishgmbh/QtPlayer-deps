#!/bin/bash

source ../config.sh

if [ -d $OPENALSOFT_TARGET ]; then
    sudo rm -rf $OPENALSOFT_TARGET
fi
if [ -d $OPENALSOFT_SRC_DIR ]; then
    sudo rm -rf $OPENALSOFT_SRC_DIR
fi

git clone --recursive https://github.com/grassfishgmbh/openal-soft buildspace
cd $OPENALSOFT_TARGET
git checkout tags/$OPENALSOFT_VERSION

cp -r $OPENALSOFT_TARGET $OPENALSOFT_SRC_DIR

echo "src fetch successful"
exit 0
