#!/bin/bash

set -e
BASEDIR=$(dirname "$0")
source $BASEDIR/../config.sh

git submodule init src
git submodule update src

echo "src fetch successful"
exit 0
