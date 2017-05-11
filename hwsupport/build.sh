#!/bin/bash

set -e
BASEDIR=$(dirname "$0")
source $BASEDIR/../config.sh

sudo rm -rf /opt/hwsupport || true

cd libva-$LIBVA_VERSION
./configure --prefix=/opt/hwsupport
make
sudo make install
cd ..

export PKG_CONFIG_PATH=/opt/hwsupport/lib/pkgconfig

cd intel-vaapi-driver-$LIBVA_VERSION
./configure --prefix=/opt/hwsupport
make
sudo make install
cd ..

tar cvzf gf-hwsupport.tar.gz /opt/hwsupport
mv gf-hwsupport.tar.gz ..
