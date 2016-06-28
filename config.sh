#!/bin/bash

CONFIG_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

QT_VERSION="5.6.1-1"
QT_DIR="/opt/Qt/$QT_VERSION/gcc_64"

VLC_VERSION="2.2.1"

QTAV_DEVRELEASE=1
QTAV_TAG="b842b648c9f8eda6a96ea719940aac57bed24c7f"
QTAV_PATCH_DIR="$CONFIG_DIR/qtav/patches"

FFMPEG_VERSION="2.8.6"

INSTALL_PREFIX="/opt/gf-builddeps"
