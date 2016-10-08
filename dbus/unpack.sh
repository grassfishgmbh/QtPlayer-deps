#!/bin/bash

source ../config.sh

# Something went wrong, so just bail
if [ ! -e "$DBUS_TARGET$DBUS_FILENAME" ]; then
    echo "$DBUS_TARGET$DBUS_FILENAME does not exist. Bailing."
    exit 1
fi

tar -xvf "$DBUS_TARGET$DBUS_FILENAME" -C "$DBUS_TARGET"

cp -r $DBUS_TARGET $DBUS_DIR/src
