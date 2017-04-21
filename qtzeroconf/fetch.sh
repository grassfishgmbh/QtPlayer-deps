#!/bin/bash

source ../config.sh

if [ -d $QTZEROCONF_TARGET ]; then
    rm -rf $QTZEROCONF_TARGET
fi

git clone https://github.com/jbagg/QtZeroConf buildspace
cd $QTZEROCONF_TARGET
git checkout $QTZEROCONF_VERSION

cp -r $QTZEROCONF_TARGET $QTZEROCONF_SRC_DIR

echo "src fetch successful"
exit 0
