#!/bin/bash

source ../config.sh

function download {
    if [ ! -f "$ZLIB_TARGET$ZLIB_FILENAME" ]; then
        wget "$ZLIB_TAR_URL" -O $ZLIB_TARGET$ZLIB_FILENAME
    fi
}

function check {
    if [ -e "$ZLIB_TARGET$ZLIB_FILENAME" ]; then
        HASH=`sha256sum $ZLIB_TARGET$ZLIB_FILENAME | awk -F" " '{print $1}'`
        if [ "$HASH" != "$ZLIB_SHA256" ]; then
            echo "$HASH != $ZLIB_SHA256"
            rm "$ZLIB_TARGET$ZLIB_FILENAME"
        fi
    fi
}

if [ ! -e $ZLIB_TARGET ]; then
    mkdir -p $ZLIB_TARGET
fi

echo "$ZLIB_TARGET$ZLIB_FILENAME"

if [ ! -e "$ZLIB_TARGET$ZLIB_FILENAME" ]; then
    echo "Downloading"
    download
    check
fi

# Something went wrong, so just bail
if [ ! -e "$ZLIB_TARGET$ZLIB_FILENAME" ]; then
    echo "$ZLIB_TARGET$ZLIB_FILENAME does not exist. Bailing."
    exit 1
fi

echo "src fetch successful"
exit 0
