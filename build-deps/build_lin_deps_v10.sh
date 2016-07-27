#!/bin/bash

set -e

source ../config.sh

MY_ROOT=`pwd`

cd ../networkmanager-qt

bash prepare.sh
bash fetch.sh
bash build.sh

cd $MY_ROOT
cd lin

bash prepare.sh
bash fetch.sh
bash build.sh

