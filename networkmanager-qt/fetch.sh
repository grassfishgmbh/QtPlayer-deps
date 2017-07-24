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

find $NM_QT_PATCH_DIR -type f -iname "*.patch" -print0 | while IFS= read -r -d $'\0' patchfile; do
    patch -p1 < $patchfile || true
done

cd $BUILDSPACE_WD
git clone git://anongit.kde.org/extra-cmake-modules

cd extra-cmake-modules
git checkout tags/$NM_QT_VERSION
cd $MY_ROOT
