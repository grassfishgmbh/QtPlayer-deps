#!/bin/bash

source ../config.sh

MY_ROOT=`pwd`

if [ -e "buildspace" ]; then
    rm -rf buildspace
fi

mkdir buildspace
cd buildspace
BUILDSPACE_WD=`pwd`

git clone git://anongit.kde.org/networkmanager-qt.git

cd networkmanager-qt
git checkout tags/$NM_QT_VERSION

cd $BUILDSPACE_WD
git clone git://anongit.kde.org/extra-cmake-modules

cd extra-cmake-modules
git checkout tags/$NM_QT_VERSION
cd $MY_ROOT
