#!/bin/bash

source ../config.sh

# additionally export PATH variables as suggested by the ffmpeg wiki 
if [ "$1" == "x86_64" ]; then
    export PATH="/cygdrive/c/Program Files (x86)/Microsoft Visual Studio 12.0/VC/BIN/amd64/":$PATH
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

INSTALL_PREFIX="$DEPS_BS_ROOT"/qtav-$1

if [ ! -e ffmpeg-$FFMPEG_VERSION.tar.bz2 ]; then
    wget http://ffmpeg.org/releases/ffmpeg-$FFMPEG_VERSION.tar.bz2
fi

if [ -e ffmpeg-$FFMPEG_VERSION ]; then
    rm -rf ffmpeg-$FFMPEG_VERSION
fi

tar xvf ffmpeg-$FFMPEG_VERSION.tar.bz2

# BUILD FFMPEG
cd ffmpeg-$FFMPEG_VERSION
./configure --extra-version=Grassfish \
            --enable-pic \
            --toolchain=msvc \
            --enable-runtime-cpudetect \
            --enable-hwaccels --enable-shared --disable-static \
            --disable-postproc \
            --prefix=$INSTALL_PREFIX

make -j`nproc`
make install
