#!/bin/bash

set -e
BASEDIR=$(dirname "$0")
source $BASEDIR/../config.sh

if [ -e $BASEDIR/../gf-hwsupport.tar.gz ]; then
    rm $BASEDIR/../gf-hwsupport.tar.gz
fi

# libva
if [ ! -e "libva-$LIBVA_VERSION.tar.bz2" ]; then
    wget https://github.com/01org/libva/releases/download/$LIBVA_VERSION/libva-$LIBVA_VERSION.tar.bz2
fi
if [ ! -d libva-$LIBVA_VERSION ]; then
    tar xvf libva-$LIBVA_VERSION.tar.bz2
fi

# libva-intel-driver
if [ ! -e "intel-vaapi-driver-$LIBVA_VERSION.tar.bz2" ]; then
    wget https://github.com/01org/intel-vaapi-driver/releases/download/$LIBVA_VERSION/intel-vaapi-driver-$LIBVA_VERSION.tar.bz2
fi
if [ ! -d intel-vaapi-driver-$LIBVA_VERSION ]; then
    tar xvf intel-vaapi-driver-$LIBVA_VERSION.tar.bz2
fi
