#!/bin/bash

set -e
pwd
source ../../config.sh

# Use the latest custom build Qt framework (for VLC-Qt)
export PATH=$QT_DIR/bin:$PATH

if [ ! -d deps-buildspace ]; then
    mkdir deps-buildspace
fi

cd deps-buildspace

DEPS_BS_ROOT=`pwd`

if [ ! -e ffmpeg-$FFMPEG_VERSION.tar.bz2 ]; then
    wget http://ffmpeg.org/releases/ffmpeg-$FFMPEG_VERSION.tar.bz2
fi

if [ ! -e vlc-$VLC_VERSION.tar.xz ]; then
    wget http://get.videolan.org/vlc/$VLC_VERSION/vlc-$VLC_VERSION.tar.xz
fi

tar xvf ffmpeg-$FFMPEG_VERSION.tar.bz2
tar xvf vlc-$VLC_VERSION.tar.xz

if [ -d QtAV ]; then
    rm -rf QtAV
fi

git clone https://github.com/wang-bin/QtAV.git
cd QtAV
if [ "$QTAV_DEVRELEASE" == "0" ]; then
    git checkout tags/$QTAV_TAG
else
    git checkout $QTAV_TAG
fi
cd ..

if [ -d gtkglext ]; then
    rm -rf gtkglext
fi

git clone git://git.gnome.org/gtkglext
cd gtkglext
git checkout $GTKGLEXT_VERSION
cd ..

