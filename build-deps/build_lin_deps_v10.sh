#!/bin/bash

set -e

# Use the latest custom build Qt framework (for VLC-Qt)
export PATH=/opt/Qt/5.6.0/gcc_64/bin:$PATH

sudo apt-get install -y libxcb1-dev \
                      libxcb-shm0-dev \
                      libxcb-composite0-dev \
                      libxcb-xv0-dev \
                      libasound2-dev \
                      libva-dev \
                      libvdpau-dev \
                      libxv-dev \
                      libpulse-dev \
                      libxcb-randr0-dev \
                      libxi-dev \
                      mesa-common-dev \
                      build-essential \
                      libgl1-mesa-dev \
                      libegl1-mesa-dev \
                      yasm \
                      cmake \
                      libpangocairo-1.0-0 \
                      libcairo2 \
                      libpango1.0-0 \
                      libgconf2-4 \
                      libatk1.0-0 \
                      libxcursor1 \
                      chrpath \
                      zip


INSTALL_PREFIX=/opt/gf-builddeps

if [ -d $INSTALL_PREFIX ]; then
    sudo rm -rf $INSTALL_PREFIX
fi

export PKG_CONFIG_PATH=$INSTALL_PREFIX/lib/pkgconfig

if [ ! -d deps-buildspace ]; then
    mkdir deps-buildspace
fi

cd deps-buildspace

DEPS_BS_ROOT=`pwd`

if [ ! -e ffmpeg-2.8.6.tar.bz2 ]; then
    wget http://ffmpeg.org/releases/ffmpeg-2.8.6.tar.bz2
fi

if [ ! -e vlc-2.2.3.tar.xz ]; then
    wget http://get.videolan.org/vlc/2.2.3/vlc-2.2.3.tar.xz
fi

if [ ! -e vlc-qt ]; then
    git clone git://github.com/vlc-qt/vlc-qt.git vlc-qt
    cd vlc-qt
    git checkout 0c235025eb3160c633799dc8430261b6c2a6949d
    git submodule init
    git submodule update
    cd ..
fi

tar xvf ffmpeg-2.8.6.tar.bz2
tar xvf vlc-2.2.3.tar.xz

# APPLY NEEDED PATCHES
#cd vlc-2.2.3
#patch -p1 < ../../libvlc_vmem_visible_rect.patch
#patch -p1 < ../../libvlc_keep_aspect_info.patch
#cd -

# BUILD FFMPEG
cd ffmpeg-2.8.6
./configure --extra-version=Grassfish \
            --enable-pic \
            --enable-runtime-cpudetect \
            --enable-hwaccels --enable-shared --disable-static \
            --disable-postproc \
            --extra-cflags=' -O3 ' \
            --extra-libs=' -lrt' \
            --prefix=$INSTALL_PREFIX

make -j`nproc`

if [ -e $INSTALL_PREFIX ]; then
    rm -rf $INSTALL_PREFIX
fi

sudo make install

# GO BACK
cd ..

# BUILD VLC
cd vlc-2.2.3

./configure --prefix=$INSTALL_PREFIX \
            --enable-x11 --enable-xvideo --disable-gtk \
            --disable-livedotcom --disable-skins --disable-skins2 --enable-alsa --disable-kde \
            --disable-qt --disable-wxwindows --disable-ncurses \
            --enable-release --disable-lua --disable-mad --disable-a52 \
            --disable-libgcrypt --disable-update-check --disable-x265 \
            --disable-taglib --disable-gnutls

make -j`nproc`

sudo make install

# BUILD VLC-QT
cd ..
cd vlc-qt

if [ -e build ]; then
    rm -rf build
fi
mkdir build

cd build

cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/opt/gf-builddeps -DLIBVLC_INCLUDE_DIR=/opt/gf-builddeps/include
make -j8
sudo make install

cd .. # vlc-qt
cd .. # deps-buildspace


if [ -e $DEPS_BS_ROOT/gf-builddeps.tar.gz ]; then
    rm -rf $DEPS_BS_ROOT/gf-builddeps.tar.gz
fi

tar cvzf gf-builddeps.tar.gz $INSTALL_PREFIX
