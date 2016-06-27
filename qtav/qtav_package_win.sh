#!/bin/bash

source ../config.sh

cd deps-buildspace
if [ -e QtAV ]; then
    rm -rf QtAV
fi
mkdir -p QtAV/$QTAV_TAG

mv qtav-x86_64 QtAV/$QTAV_TAG/x86_64
mv qtav-i686 QtAV/$QTAV_TAG/i686

zip -r QtAV.zip QtAV
mv QtAV.zip ../../QtAV-win.zip
