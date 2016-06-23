#!/bin/bash

if [ "$1" == "x86_64" ]; then
    export PATH="/c/Program Files (x86)/Microsoft Visual Studio 12.0/VC/BIN/amd64/":$PATH
elif [ "$1" == "i686" ]; then
    export PATH="/c/Program Files (x86)/Microsoft Visual Studio 12.0/VC/BIN/":$PATH
fi

if [ ! -d deps-buildspace ]; then
    mkdir deps-buildspace
fi

cd deps-buildspace

DEPS_BS_ROOT=`pwd`

if [ ! -e ffmpeg-2.8.6.tar.bz2 ]; then
    wget http://ffmpeg.org/releases/ffmpeg-2.8.6.tar.bz2
fi

tar xvf ffmpeg-2.8.6.tar.bz2

# BUILD FFMPEG
cd ffmpeg-2.8.6
./configure --extra-version=Grassfish \
            --enable-pic \
            --toolchain=msvc \
            --enable-runtime-cpudetect \
            --enable-hwaccels --enable-shared --disable-static \
            --disable-postproc \
            --extra-cflags=' -O3 ' \
            --extra-libs=' -lrt' \
            --prefix=$INSTALL_PREFIX

make -j`nproc`
make install
