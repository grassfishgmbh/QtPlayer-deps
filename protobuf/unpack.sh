#!/bin/bash

source ../config.sh

# Something went wrong, so just bail
if [ ! -e "$PROTOBUF_TARGET$PROTOBUF_FILENAME" ]; then
    echo "$PROTOBUF_TARGET$PROTOBUF_FILENAME does not exist. Bailing."
    exit 1
fi

tar -xzvf "$PROTOBUF_TARGET$PROTOBUF_FILENAME" -C "$PROTOBUF_TARGET"

