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

mkdir gstreamer-$GSTREAMER_VERSION && cd gstreamer-$GSTREAMER_VERSION
$SOURCEDIR/gstreamer-$GSTREAMER_VERSION/autogen.sh --prefix=$DESTDIR --disable-examples --disable-gtk-doc-html --disable-debug --disable-tests --disable-failing-tests --disable-benchmarks --disable-gtk-doc --disable-gst-debug
make -j$PROC
sudo make install
cd ..

mkdir gst-plugins-base-$GSTREAMER_VERSION && cd gst-plugins-base-$GSTREAMER_VERSION
$SOURCEDIR/gst-plugins-base-$GSTREAMER_VERSION/autogen.sh --prefix=$DESTDIR --enable-iso-codes --enable-orc --disable-examples --disable-gtk-doc-html --disable-gtk-doc --disable-debug
make -j$PROC
sudo make install
cd ..

mkdir gst-plugins-good-$GSTREAMER_VERSION && cd gst-plugins-good-$GSTREAMER_VERSION
$SOURCEDIR/gst-plugins-good-$GSTREAMER_VERSION/autogen.sh --prefix=$DESTDIR --enable-orc --disable-examples --disable-gtk-doc-html --disable-gtk-doc --disable-debug
make -j$PROC
sudo make install
cd ..

mkdir gst-plugins-ugly-$GSTREAMER_VERSION && cd gst-plugins-ugly-$GSTREAMER_VERSION
$SOURCEDIR/gst-plugins-ugly-$GSTREAMER_VERSION/autogen.sh --prefix=$DESTDIR --enable-orc --disable-examples --disable-gtk-doc-html --disable-gtk-doc --disable-debug
make -j$PROC
sudo make install
cd ..

mkdir gst-libav-$GSTREAMER_VERSION && cd gst-libav-$GSTREAMER_VERSION
$SOURCEDIR/gst-libav-$GSTREAMER_VERSION/autogen.sh --prefix=$DESTDIR --enable-orc --disable-gtk-doc-html --disable-gtk-doc --disable-debug
make -j$PROC
sudo make install
cd ..

mkdir gst-plugins-bad-$GSTREAMER_VERSION && cd gst-plugins-bad-$GSTREAMER_VERSION
$SOURCEDIR/gst-plugins-bad-$GSTREAMER_VERSION/autogen.sh --prefix=$DESTDIR --enable-orc --disable-examples --disable-gtk-doc-html --disable-gtk-doc --disable-debug
make -j$PROC
sudo make install
cd ..

mkdir gstreamer-vaapi-$GSTREAMER_VERSION && cd gstreamer-vaapi-$GSTREAMER_VERSION
$SOURCEDIR/gstreamer-vaapi-$GSTREAMER_VERSION/autogen.sh --prefix=$DESTDIR --disable-examples --disable-gtk-doc-html --disable-gtk-doc --disable-debug
make -j$PROC
sudo make install
cd ..

tar cvzf gf-gstreamer.tar.gz $DESTDIR
mv gf-gstreamer.tar.gz ..
