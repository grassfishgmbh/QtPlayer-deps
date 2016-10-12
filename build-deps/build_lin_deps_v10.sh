#!/bin/bash

set -e

source ../config.sh

MY_ROOT=`pwd`

cd lin

bash prepare.sh
bash fetch.sh
bash build.sh

cd $MY_ROOT/../networkmanager-qt

bash prepare.sh
bash fetch.sh
bash build.sh

cd $MY_ROOT/../dbus

bash fetch.sh
bash unpack.sh
bash build.sh

cd $MY_ROOT/../libusb
bash autogen.sh

cd $MY_ROOT/../kdsoap
bash build.sh

cd $MY_ROOT/../zlib
bash build.sh

cd $MY_ROOT/../libssh
bash build.sh

cd $MY_ROOT/../curl
bash build.sh

cd $MY_ROOT/../QtWebApp
bash build.sh

cd $MY_ROOT/../qtpdfium
bash build.sh

cd $MY_ROOT/../quazip
bash build.sh

cd $MY_ROOT/lin

bash package.sh
