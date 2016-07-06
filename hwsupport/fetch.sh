#!/bin/bash

set -e
BASEDIR=$(dirname "$0")
source $BASEDIR/../config.sh

if [ -e $BASEDIR/../gf-hwsupport.tar.gz ]; then
    rm $BASEDIR/../gf-hwsupport.tar.gz
fi

# libva
if [ ! -e "libva-$LIBVA_VERSION.tar.bz2" ]; then
    wget https://www.freedesktop.org/software/vaapi/releases/libva/libva-$LIBVA_VERSION.tar.bz2
fi
if [ ! -d libva-$LIBVA_VERSION ]; then
    tar xvf libva-$LIBVA_VERSION.tar.bz2
fi

# libva-intel-driver
if [ ! -e "libva-intel-driver-$LIBVA_VERSION.tar.bz2" ]; then
    wget https://www.freedesktop.org/software/vaapi/releases/libva-intel-driver/libva-intel-driver-$LIBVA_VERSION.tar.bz2
fi
if [ ! -d libva-intel-driver-$LIBVA_VERSION ]; then
    tar xvf libva-intel-driver-$LIBVA_VERSION.tar.bz2
fi
