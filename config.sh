#!/bin/bash

CONFIG_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ `uname -o` != "GNU/Linux" ]; then
    alias sudo=
fi

QT_VERSION="5.6.1-1"
QTWEBENGINE_VERSION="5.7.0"
QT_DIR="/opt/Qt/$QT_VERSION/gcc_64"
QT_PATCH_DIR="$CONFIG_DIR/qt/patches"

if [ "$GF_QT_IS_32_BIT_BUILD" == "" ]; then
    QT_DIR_WIN="C:\Qt\\$QT_VERSION\msvc2013_64"
else
    QT_DIR_WIN="C:\Qt\\$QT_VERSION\msvc2013"
fi

if [ "$QT_SRC_DIR" == "" ]; then
    QT_SRC_DIR="$CONFIG_DIR\qt\5.6\qt-src"
fi

VLC_VERSION="2.2.1"

QTAV_DEVRELEASE=1
QTAV_TAG="2d0dd1d1c806dba4e6ec2af58e6186df6b533c58"
QTAV_PATCH_DIR="$CONFIG_DIR/qtav/patches"

FFMPEG_VERSION="2.8.6"

OPENSSL_VERSION="1.0.2h"
OPENSSL_DIR=$CONFIG_DIR/openssl

INSTALL_PREFIX="/opt/gf-builddeps"
