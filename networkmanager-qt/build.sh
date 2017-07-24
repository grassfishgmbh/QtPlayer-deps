#!/bin/bash

source ../config.sh

unset LD_LIBRARY_PATH

MY_ROOT=`pwd`

which qmake

cd buildspace/extra-cmake-modules
mkdir build
cd build
CMAKE_PREFIX_PATH=$QT_DIR cmake .. -DCMAKE_INSTALL_PREFIX:PATH=$NMQT_INSTALL_PREFIX
make -j`nproc`
sudo make install

cd $MY_ROOT

cd buildspace/networkmanager-qt

mkdir build
cd build
CMAKE_PREFIX_PATH=$QT_DIR cmake .. -DCMAKE_INSTALL_PREFIX:PATH=$NMQT_INSTALL_PREFIX -DCMAKE_MODULE_PATH=$NMQT_INSTALL_PREFIX/share/ECM/cmake/
make -j`nproc`
sudo make install

cd $MY_ROOT
