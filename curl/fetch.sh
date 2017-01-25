#!/bin/bash

source ../config.sh

function download {
    if [ ! -f "$CURL_TARGET$CURL_FILENAME" ]; then
        wget --no-check-certificate "$CURL_TAR_URL" -O $CURL_TARGET$CURL_FILENAME
    fi
}

function check {
    if [ -e "$CURL_TARGET$CURL_FILENAME" ]; then
        HASH=`sha256sum $CURL_TARGET$CURL_FILENAME | awk -F" " '{print $1}'`
        if [ "$HASH" != "$CURL_SHA256" ]; then
            echo "$HASH != $CURL_SHA256"
            rm "$CURL_TARGET$CURL_FILENAME"
        fi
    fi
}

if [ ! -e $CURL_TARGET ]; then
    mkdir -p $CURL_TARGET
fi

echo "$CURL_TARGET$CURL_FILENAME"

if [ ! -e "$CURL_TARGET$CURL_FILENAME" ]; then
    echo "Downloading"
    download
    check
fi

# Something went wrong, so just bail
if [ ! -e "$CURL_TARGET$CURL_FILENAME" ]; then
    echo "$CURL_TARGET$CURL_FILENAME does not exist. Bailing."
    exit 1
fi

echo "src fetch successful"
exit 0
