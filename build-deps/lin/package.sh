#!/bin/bash


set -e

source ../../config.sh

if [ -e gf-builddeps.tar.gz ]; then
    rm -rf gf-builddeps.tar.gz
fi

tar cvzf gf-builddeps.tar.gz $INSTALL_PREFIX $NMQT_INSTALL_PREFIX
