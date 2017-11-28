#!/bin/bash

source ../config.sh

function downloadLibusb {
    if [ ! -f "$LIBUSB_TARGET/$LIBUSB_FILENAME" ]; then
        wget --no-check-certificate "$LIBUSB_TAR_URL" -O $LIBUSB_TARGET/$LIBUSB_FILENAME
    fi
}

function checkHash {
    if [ -e "$LIBUSB_TARGET/$LIBUSB_FILENAME" ]; then
        HASH=`sha256sum $LIBUSB_TARGET/$LIBUSB_FILENAME | awk -F" " '{print $1}'`
        if [ "$HASH" != "$LIBUSB_SHA256" ]; then
            echo "Existing base OS iso hash doesn't match."
            rm "$LIBUSB_TARGET/$LIBUSB_FILENAME"
        fi
    fi
}

if [ ! -e $LIBUSB_TARGET ]; then
    mkdir -p $LIBUSB_TARGET
fi

if [ ! -e "$LIBUSB_TARGET/$LIBUSB_FILENAME" ]; then
    echo "Downloading "
    downloadLibusb
    checkHash
fi

# Something went wrong, so just bail
if [ ! -e "$LIBUSB_TARGET/$LIBUSB_FILENAME" ]; then
    echo "$LIBUSB_TARGET/$LIBUSB_FILENAME does not exist. Bailing."
    exit 1
fi

echo "src fetch successful"
exit 0
