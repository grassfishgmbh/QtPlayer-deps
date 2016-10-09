#!/bin/bash

set -e

BASEDIR=$(dirname "$0")

source $BASEDIR/../config.sh

if [ -e build ]; then
    rm -rf build
fi
mkdir build
cd build

qmake ../qtpdfium.pro PREFIX=$INSTALL_PREFIX CONFIG+=debug_and_release

make -j`nproc`
sudo cp -r {include,lib,mkspecs} $INSTALL_PREFIX/
sudo cp ../src/pdfium/*.h $INSTALL_PREFIX/include/QtPdfium
