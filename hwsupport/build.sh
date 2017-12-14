#!/bin/bash

set -e
BASEDIR=$(dirname "$0")
source $BASEDIR/../config.sh
cd $BASEDIR/src

sudo rm -rf /opt/hwsupport || true

cd libva
./autogen.sh --prefix=/opt/hwsupport
make -j`nproc`
sudo make install
cd ..

export PKG_CONFIG_PATH=/opt/hwsupport/lib/pkgconfig

cd intel-vaapi-driver
./configure --prefix=/opt/hwsupport
make -j `nproc`
sudo make install
cd ..

tar cvzf gf-hwsupport.tar.gz /opt/hwsupport
mv gf-hwsupport.tar.gz ..
