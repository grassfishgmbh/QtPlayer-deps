#!/bin/bash

set -e
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $BASEDIR
source $BASEDIR/../config.sh

git submodule init src
git submodule update src

echo "src fetch successful"
exit 0
