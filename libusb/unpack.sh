#!/bin/bash

source ../config.sh

# Something went wrong, so just bail
if [ ! -e "$LIBUSB_TARGET$LIBUSB_FILENAME" ]; then
    echo "$LIBUSB_TARGET$LIBUSB_FILENAME does not exist. Bailing."
    exit 1
fi

tar -xvf "$LIBUSB_TARGET$LIBUSB_FILENAME" -C "$LIBUSB_TARGET"
mkdir $LIBUSB_DIR/src || true
tar -xvf "$LIBUSB_TARGET$LIBUSB_FILENAME" -C $LIBUSB_DIR/src
