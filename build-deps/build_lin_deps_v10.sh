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

cd $MY_ROOT ../dbus

bash fetch.sh
bash unpack.sh
bash build.sh

cd $MY_ROOT/lin

bash package.sh
