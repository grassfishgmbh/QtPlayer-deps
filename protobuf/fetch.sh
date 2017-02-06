#!/bin/bash

source ../config.sh

function download {
    if [ ! -f "$PROTOBUF_TARGET$PROTOBUF_FILENAME" ]; then
        wget --no-check-certificate "$PROTOBUF_TAR_URL" -O $PROTOBUF_TARGET$PROTOBUF_FILENAME
    fi
}

function check {
    if [ -e "$PROTOBUF_TARGET$PROTOBUF_FILENAME" ]; then
        HASH=`sha256sum $PROTOBUF_TARGET$PROTOBUF_FILENAME | awk -F" " '{print $1}'`
        if [ "$HASH" != "$PROTOBUF_SHA256" ]; then
            echo "$HASH != $PROTOBUF_SHA256"
            rm "$PROTOBUF_TARGET$PROTOBUF_FILENAME"
        fi
    fi
}

if [ ! -e $PROTOBUF_TARGET ]; then
    mkdir -p $PROTOBUF_TARGET
fi

echo "$PROTOBUF_TARGET$PROTOBUF_FILENAME"

if [ ! -e "$PROTOBUF_TARGET$PROTOBUF_FILENAME" ]; then
    echo "Downloading"
    download
    check
fi

# Something went wrong, so just bail
if [ ! -e "$PROTOBUF_TARGET$PROTOBUF_FILENAME" ]; then
    echo "$PROTOBUF_TARGET$PROTOBUF_FILENAME does not exist. Bailing."
    exit 1
fi

echo "src fetch successful"
exit 0
