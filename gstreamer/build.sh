#!/bin/bash

set -e
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $BASEDIR/../config.sh


SOURCEDIR=$BASEDIR/src
PROC=`nproc`
DESTDIR=$INSTALL_PREFIX/gstreamer


export PATH=$DESTDIR/bin:$PATH
export LD_LIBRARY_PATH=$DESTDIR/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=$DESTDIR/lib/pkgconfig:$PKG_CONFIG_PATH

sudo rm -rf $DESTDIR || true
sudo rm -rf build || true
mkdir $BASEDIR/build && cd $BASEDIR/build

mkdir gstreamer && cd gstreamer
$SOURCEDIR/gstreamer/autogen.sh --prefix=$DESTDIR --disable-examples --disable-gtk-doc-html --disable-debug --disable-tests --disable-failing-tests --disable-benchmarks --disable-gtk-doc --disable-gst-debug
make -j$PROC
sudo make install
cd ..

mkdir gst-plugins-base && cd gst-plugins-base
$SOURCEDIR/gst-plugins-base/autogen.sh --prefix=$DESTDIR --enable-iso-codes --enable-orc --disable-examples --disable-gtk-doc-html --disable-gtk-doc --disable-debug
make -j$PROC
sudo make install
cd ..

mkdir gst-plugins-good && cd gst-plugins-good
$SOURCEDIR/gst-plugins-good/autogen.sh --prefix=$DESTDIR --enable-orc --disable-examples --disable-gtk-doc-html --disable-gtk-doc --disable-debug
make -j$PROC
sudo make install
cd ..

mkdir gst-plugins-ugly && cd gst-plugins-ugly
$SOURCEDIR/gst-plugins-ugly/autogen.sh --prefix=$DESTDIR --enable-orc --disable-examples --disable-gtk-doc-html --disable-gtk-doc --disable-debug
make -j$PROC
sudo make install
cd ..

mkdir gst-libav && cd gst-libav
$SOURCEDIR/gst-libav/autogen.sh --prefix=$DESTDIR --enable-orc --disable-gtk-doc-html --disable-gtk-doc --disable-debug
make -j$PROC
sudo make install
cd ..

mkdir gst-plugins-bad && cd gst-plugins-bad
$SOURCEDIR/gst-plugins-bad/autogen.sh --prefix=$DESTDIR --enable-orc --disable-examples --disable-gtk-doc-html --disable-gtk-doc --disable-debug
make -j$PROC
sudo make install
cd ..

mkdir gstreamer-vaapi && cd gstreamer-vaapi
$SOURCEDIR/gstreamer-vaapi/autogen.sh --prefix=$DESTDIR --disable-examples --disable-gtk-doc-html --disable-gtk-doc --disable-debug
make -j$PROC
sudo make install
cd ..

tar cvzf gf-gstreamer.tar.gz $DESTDIR
mv gf-gstreamer.tar.gz ..
