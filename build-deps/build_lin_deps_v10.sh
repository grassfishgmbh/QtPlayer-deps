#!/bin/bash

set -e

source ../config.sh

cd lin
bash prepare.sh
bash fetch.sh
bash build.sh
bash package.sh
