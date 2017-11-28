#!/bin/bash

source ../config.sh

# Something went wrong, so just bail
if [ ! -e "$CURL_TARGET/$CURL_FILENAME" ]; then
    echo "$CURL_TARGET/$CURL_FILENAME does not exist. Bailing."
    exit 1
fi

tar -xvf "$CURL_TARGET/$CURL_FILENAME" -C "$CURL_TARGET"

#cp -r $CURL_TARGET $CURL_DIR/src
