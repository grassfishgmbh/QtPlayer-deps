#!/bin/bash

set -e
BASEDIR=$(dirname "$0")
source $BASEDIR/../config.sh

if [ -e $BASEDIR/../gf-gstreamer.tar.gz ]; then
    rm $BASEDIR/../gf-gstreamer.tar.gz
fi

sudo rm -rf src || true
mkdir src

# gstreamer requires a complete git repository to checkout dependencies!
git clone --branch $GSTREAMER_VERSION git://anongit.freedesktop.org/git/gstreamer/gstreamer src/gstreamer-$GSTREAMER_VERSION
git clone --branch $GSTREAMER_VERSION git://anongit.freedesktop.org/git/gstreamer/gst-plugins-base src/gst-plugins-base-$GSTREAMER_VERSION
git clone --branch $GSTREAMER_VERSION git://anongit.freedesktop.org/git/gstreamer/gst-plugins-good src/gst-plugins-good-$GSTREAMER_VERSION
git clone --branch $GSTREAMER_VERSION git://anongit.freedesktop.org/git/gstreamer/gst-plugins-bad src/gst-plugins-bad-$GSTREAMER_VERSION
git clone --branch $GSTREAMER_VERSION git://anongit.freedesktop.org/git/gstreamer/gst-plugins-ugly src/gst-plugins-ugly-$GSTREAMER_VERSION
git clone --branch $GSTREAMER_VERSION git://anongit.freedesktop.org/git/gstreamer/gst-libav src/gst-libav-$GSTREAMER_VERSION
git clone --branch $GSTREAMER_VERSION git://anongit.freedesktop.org/git/gstreamer/gstreamer-vaapi src/gstreamer-vaapi-$GSTREAMER_VERSION

# further depenencies will be checked out by autogen.sh scripts in build step!
