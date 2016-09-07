#!/bin/bash

source ../config.sh

function download {
    if [ ! -f "$DBUS_TARGET$DBUS_FILENAME" ]; then
        wget "$DBUS_URL" -O $DBUS_TARGET$DBUS_FILENAME
    fi
}

function checkHash {
    if [ -e "$DBUS_TARGET$DBUS_FILENAME" ]; then
        HASH=`sha256sum $DBUS_TARGET$DBUS_FILENAME | awk -F" " '{print $1}'`
        if [ "$HASH" != "$DBUS_SHA256" ]; then
            echo "Hash doesn't match."
            rm "$DBUS_TARGET$DBUS_FILENAME"
        fi
    fi
}

if [ ! -e $DBUS_TARGET ]; then
    mkdir -p $DBUS_TARGET
fi

if [ ! -e "$DBUS_TARGET$DBUS_FILENAME" ]; then
    echo "Downloading "
    download
    checkHash
fi

# Something went wrong, so just bail
if [ ! -e "$DBUS_TARGET$DBUS_FILENAME" ]; then
    echo "$DBUS_TARGET$DBUS_FILENAME does not exist. Bailing."
    exit 1
fi

echo "src fetch successful"
exit 0
