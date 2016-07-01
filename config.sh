#!/bin/bash

CONFIG_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

QT_VERSION="5.6.1-1"
QTWEBENGINE_VERSION="5.7.0"
QT_DIR="/opt/Qt/$QT_VERSION/gcc_64"
QT_PATCH_DIR="$CONFIG_DIR/qt/patches"

VLC_VERSION="2.2.1"

QTAV_DEVRELEASE=1
QTAV_TAG="2d0dd1d1c806dba4e6ec2af58e6186df6b533c58"
QTAV_PATCH_DIR="$CONFIG_DIR/qtav/patches"

FFMPEG_VERSION="2.8.6"

INSTALL_PREFIX="/opt/gf-builddeps"
