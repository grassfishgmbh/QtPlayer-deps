#!/bin/bash

set -e
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $BASEDIR
source $BASEDIR/../config.sh

git submodule update --init src

cd src
sed -i "s/signals/Q_SIGNALS/g" qzeroconf.h
sed -i "s/slots/Q_SLOTS/g" qzeroconf.h

echo "src fetch successful"
exit 0
