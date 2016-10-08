#!/bin/bash

source ../config.sh

# Something went wrong, so just bail
if [ ! -e "$ZLIB_TARGET$ZLIB_FILENAME" ]; then
    echo "$ZLIB_TARGET$ZLIB_FILENAME does not exist. Bailing."
    exit 1
fi

tar -xvf "$ZLIB_TARGET$ZLIB_FILENAME" -C "$ZLIB_TARGET"

cp -r $ZLIB_TARGET $ZLIB_DIR/src
