#!/bin/bash

set -e
BASEDIR=$(dirname "$0")
source $BASEDIR/../config.sh

sudo rm -rf /opt/gstreamer || true

export PATH=/opt/gstreamer/bin:$PATH
export LD_LIBRARY_PATH=/opt/gstreamer/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=/opt/gstreamer/lib/pkgconfig:$PKG_CONFIG_PATH

cd gstreamer-$GSTREAMER_VERSION
./autogen.sh --prefix=/opt/gstreamer --disable-examples --disable-gtk-doc-html --disable-debug --disable-tests --disable-failing-tests --disable-benchmarks --disable-gtk-doc --disable-gst-debug
make -j4
sudo make install
cd ..

cd gst-plugins-base-$GSTREAMER_VERSION
./autogen.sh --prefix=/opt/gstreamer --enable-iso-codes --enable-orc --disable-examples --disable-gtk-doc-html --disable-gtk-doc --disable-debug
make -j4
sudo make install
cd ..

cd gst-plugins-good-$GSTREAMER_VERSION
./autogen.sh --prefix=/opt/gstreamer --enable-orc --disable-examples --disable-gtk-doc-html --disable-gtk-doc --disable-debug
make -j4
sudo make install
cd ..

cd gst-plugins-ugly-$GSTREAMER_VERSION
./autogen.sh --prefix=/opt/gstreamer --enable-orc --disable-examples --disable-gtk-doc-html --disable-gtk-doc --disable-debug
make -j4
sudo make install
cd ..

cd gst-libav-$GSTREAMER_VERSION
./autogen.sh --prefix=/opt/gstreamer --enable-orc --disable-gtk-doc-html --disable-gtk-doc --disable-debug
make -j4
sudo make install
cd ..

cd gst-plugins-bad-$GSTREAMER_VERSION
./autogen.sh --prefix=/opt/gstreamer --enable-orc --disable-examples --disable-gtk-doc-html --disable-gtk-doc --disable-debug
make -j4
sudo make install
cd ..

cd gstreamer-vaapi-$GSTREAMER_VERSION
./autogen.sh --prefix=/opt/gstreamer --disable-examples --disable-gtk-doc-html --disable-gtk-doc --disable-debug
make -j4
sudo make install
cd ..

tar cvzf gf-gstreamer.tar.gz /opt/gstreamer
mv gf-gstreamer.tar.gz ..
