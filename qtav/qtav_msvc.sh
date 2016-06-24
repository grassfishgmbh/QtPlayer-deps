#!/bin/bash

# additionally export PATH variables as suggested by the ffmpeg wiki 
if [ "$1" == "x86_64" ]; then
    export PATH="/cygdrive/c/Program Files (x86)/Microsoft Visual Studio 12.0/VC/BIN/amd64:$PATH"
elif [ "$1" == "i686" ]; then
    export PATH="/cygdrive/c/Program Files (x86)/Microsoft Visual Studio 12.0/VC/BIN/":$PATH
else
    echo "No architecture set as argument, bailing."
    exit 1
fi

if [ ! -d deps-buildspace ]; then
    mkdir deps-buildspace
fi

cd deps-buildspace

DEPS_BS_ROOT=`pwd`

INSTALL_PREFIX="$DEPS_BS_ROOT/qtav-$1"
INSTALL_PREFIX_WIN=`cygpath $INSTALL_PREFIX -a -w`

# We require ffmpeg to already exist in the INSTALL_PREFIX
# Now set the environment variables to allow linking to ffmpeg
export INCLUDE="$INSTALL_PREFIX_WIN\\include;$INCLUDE"
export LIB="$INSTALL_PREFIX_WIN\\lib;$INSTALL_PREFIX_WIN\\bin;$LIB"

if [ -d QtAV ]; then
    rm -rf QtAV
fi

if [ -d build-QtAV ]; then
    rm -rf build-QtAV
fi

git clone https://github.com/wang-bin/QtAV.git
cd QtAV
git checkout tags/v1.11.0

cd ..
mkdir build-QtAV
#cd build-QtAV
#qmake ../QtAV/QtAV.pro PREFIX="$INSTALL_PREFIX_WIN"
#make -j`nproc`
