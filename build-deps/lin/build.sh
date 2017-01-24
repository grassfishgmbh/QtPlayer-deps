#!/bin/bash

set -e

MY_ROOT=`pwd`/..

source ../../config.sh

cd deps-buildspace
DEPS_BS_ROOT=`pwd`

# Use the latest custom build Qt framework (for VLC-Qt)
export PATH=$QT_DIR/bin:$PATH
export PKG_CONFIG_PATH=$INSTALL_PREFIX/lib/pkgconfig

if [ -d $INSTALL_PREFIX ]; then
    sudo rm -rf $INSTALL_PREFIX
fi

# BUILD FFMPEG
cd ffmpeg-$FFMPEG_VERSION
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
# NOTE: Disabled as of 24.01.2017 due to VLC/QtAV ffmpeg mismatch
cd vlc-$VLC_VERSION

#./configure --prefix=$INSTALL_PREFIX \
#            --enable-x11 --enable-xvideo --disable-gtk \
#            --disable-livedotcom --disable-skins --disable-skins2 --enable-alsa --disable-kde \
#            --disable-qt --disable-wxwindows --disable-ncurses \
#            --enable-release --disable-lua --disable-mad --disable-a52 \
#            --disable-libgcrypt --disable-update-check --disable-x265 \
#            --disable-taglib --disable-gnutls

#make -j`nproc`
#sudo make install

# BUILD VLC-Qt
#cd $DEPS_BS_ROOT
#cd vlc-qt
#
#if [ -e build ]; then
#    rm -rf build
#fi
#mkdir build
#
#cd build
#
#cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/opt/gf-builddeps -DLIBVLC_INCLUDE_DIR=/opt/gf-builddeps/include
#make -j`nproc`
#sudo make install
#
#cd .. # vlc-qt
#cd .. # deps-buildspace

# BUILD QtAV
cd $DEPS_BS_ROOT

export CPATH=$INSTALL_PREFIX/include:$CPATH
export LIBRARY_PATH=$INSTALL_PREFIX/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=$LIBRARY_PATH:$LD_LIBRARY_PATH

if [ -d build-QtAV ]; then
    rm -rf build-QtAV
fi

cd QtAV

find $QTAV_PATCH_DIR -type f -iname "*.patch" -print0 | while IFS= read -r -d $'\0' patchfile; do
    patch -p1 < $patchfile || true
done

cd ..
mkdir build-QtAV
cd build-QtAV

qmake ../QtAV/QtAV.pro
make -j`nproc`


QT_DIR_ESCAPED=`echo $QT_DIR | sed s,/,\\\\\\\\\\/,g`
INSTALL_PREFIX_ESCAPED=`echo $INSTALL_PREFIX | sed s,/,\\\\\\\\\\/,g`
sed -i "s/$QT_DIR_ESCAPED/$INSTALL_PREFIX_ESCAPED/g" sdk_install.sh

sudo mkdir -p $INSTALL_PREFIX/mkspecs/features
sudo mkdir -p $INSTALL_PREFIX/mkspecs/modules
chmod a+x sdk_install.sh
if [ ! -e $INSTALL_PREFIX/qml/QtAV ]; then
    sudo mkdir -p $INSTALL_PREFIX/qml/QtAV
fi
sudo ./sdk_install.sh

cd $INSTALL_PREFIX
find -iname "*.pri" -type f -exec sed -i "s/$QT_DIR_ESCAPED/$INSTALL_PREFIX_ESCAPED/g" {} \;

cd $DEPS_BS_ROOT

cd gtkglext
export LDFLAGS="-lm -lGL "`pkg-config --libs-only-l gmodule-2.0 gtk+-2.0 gthread-2.0`
autoreconf --install
./configure --prefix=$INSTALL_PREFIX --disable-static --disable-gtk-doc
make -j`nproc`
sudo make install
cd $DEPS_BS_ROOT

cd $MY_ROOT/../networkmanager-qt
bash prepare.sh
bash fetch.sh
bash build.sh

cd $MY_ROOT/../dbus
bash fetch.sh
bash unpack.sh
bash build.sh

cd $MY_ROOT/../openssl
bash fetch.sh
bash build.sh

cd $MY_ROOT/../libusb
bash autogen.sh

cd $MY_ROOT/../kdsoap
bash build.sh

cd $MY_ROOT/../zlib
bash fetch.sh
bash unpack.sh
bash build.sh

cd $MY_ROOT/../libssh
bash build.sh

cd $MY_ROOT/../curl
bash fetch.sh
bash unpack.sh
bash build.sh

cd $MY_ROOT/../QtWebApp
bash build.sh

cd $MY_ROOT/../qtpdfium
bash build.sh

cd $MY_ROOT/../quazip
bash build.sh

cd $MY_ROOT/lin
