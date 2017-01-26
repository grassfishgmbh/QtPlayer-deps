#!/bin/bash

source ../config.sh

if [ "$1" == "x86_64" ]; then
    OLD_INSTALL_TARGET="C:\Qt\\$QT_VERSION\\${VSCOMPILER}_64"
elif [ "$1" == "i686" ]; then
    OLD_INSTALL_TARGET="C:\Qt\\$QT_VERSION\\${VSCOMPILER}"
else
    echo "No architecture provided as argument, bailing."
    exit 1
fi

NEW_INSTALL_TARGET=`cygpath -w -a $PWD`\\deps-buildspace\\qtav-$1

OLD_INSTALL_TARGET_ESC=$(echo $OLD_INSTALL_TARGET | sed 's/\\/\\\\/g')
NEW_INSTALL_TARGET_ESC=$(echo $NEW_INSTALL_TARGET | sed 's/\\/\\\\/g')

cd deps-buildspace/build-QtAV

# fix the QtAV-generated install batch script to install into
# the dedicated install target (which we zip up post build)
sed -i "s/$OLD_INSTALL_TARGET_ESC/$NEW_INSTALL_TARGET_ESC/g" sdk_install.bat

# create additional directories usually found in a Qt target
mkdir -p $NEW_INSTALL_TARGET/mkspecs/features
mkdir -p $NEW_INSTALL_TARGET/mkspecs/modules

# install this mofucker
cmd /C sdk_install.bat
