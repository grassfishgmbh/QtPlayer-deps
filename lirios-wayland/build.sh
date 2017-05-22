#!/bin/bash

source ../config.sh
export PATH=${INSTALL_PREFIX}/bin:${PATH}

set -e

cd $LIRIOSWAYLAND_TARGET

qbs setup-toolchains --type gcc /usr/bin/g++ gcc
qbs setup-qt $QT_DIR/bin/qmake qt5
qbs config profiles.qt5.baseProfile gcc
sudo env "PATH=$PATH" qbs -d build -j $(nproc) profile:qt5 qbs.installRoot:${INSTALL_PREFIX}

