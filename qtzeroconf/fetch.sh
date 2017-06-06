#!/bin/bash

source ../config.sh

if [ -d $QTZEROCONF_TARGET ]; then
    rm -rf $QTZEROCONF_TARGET
fi

rm -rf src || true
mkdir src

git clone https://github.com/jbagg/QtZeroConf buildspace
cd $QTZEROCONF_TARGET
git checkout $QTZEROCONF_VERSION

sed -i "s/signals/Q_SIGNALS/g" qzeroconf.h
sed -i "s/slots/Q_SLOTS/g" qzeroconf.h

cp -r $QTZEROCONF_TARGET $QTZEROCONF_SRC_DIR

echo "src fetch successful"
exit 0
