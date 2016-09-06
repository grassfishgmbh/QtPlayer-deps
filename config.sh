#!/bin/bash

CONFIG_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

QT_VERSION="5.7.0"
QTWEBENGINE_VERSION="5.7.0"
QT_DIR="/opt/Qt/$QT_VERSION/gcc_64"
QT_PATCH_DIR="$CONFIG_DIR/qt/patches"
QT_NO_CLEAN_SRC=0

if [ `uname -o` != "GNU/Linux" ]; then
    alias sudo=
    if [ "$GF_QT_IS_32_BIT_BUILD" == "" ]; then
        QT_DIR_WIN="C:\Qt\\$QT_VERSION\msvc2013_64"
        OSSL_PREFIX="C:\openssl64"
    else
        QT_DIR_WIN="C:\Qt\\$QT_VERSION\msvc2013"
        OSSL_PREFIX="C:\openssl32"
    fi
fi

if [ "$QT_SRC_DIR" == "" ]; then
    QT_SRC_DIR="$CONFIG_DIR/qt/5.6/qt-src"
fi

VLC_VERSION="2.2.1"

QTAV_DEVRELEASE=1
QTAV_TAG="51fb47577a8c8bc681faa2c27180a1c65671c078"
QTAV_PATCH_DIR="$CONFIG_DIR/qtav/patches"

FFMPEG_VERSION="2.8.6"

OPENSSL_VERSION="1.0.2h"
OPENSSL_DIR=$CONFIG_DIR/openssl

LIBVA_VERSION="1.7.1"

GTKGLEXT_VERSION="04131c5f69070b2f194f02edd45b0622ca03793c"

NM_QT_VERSION="v5.20.0"

BASE_OS_VERSION="14.04.5"
BASE_ISO_FILE="lubuntu-$BASE_OS_VERSION-desktop-amd64.iso"
BASE_OS_SHA256="c05f756554ec4e546bfa130215ec1cbe3905fb6b43db41c6da967d96419bce9b"
ISO_BUILDSPACE=$CONFIG_DIR/create-iso/buildspace
ISO_CASPER_DIR=$ISO_BUILDSPACE/newIso/casper
UPDEBS_CHROOT=$ISO_BUILDSPACE/chroot
ISO_GENERIC_MODS_PATH=$CONFIG_DIR/create-iso/generic
ISO_CUSTOMIZATION_PATH=$CONFIG_DIR/create-iso/custom
UPDATE_ZIP_PATH=$CONFIG_DIR/create-iso/update
ISO_MOUNT=/mnt/gf_iso_mount
ISO_DESKTOP_ENVIRONMENT=lubuntu-desktop
ISO_DESKTOP_SESSION=Lubuntu
ISO_KERNEL_FLAGS="quiet splash i915.enable_psr=0 i915.enable_fbc=0 intel_pstate=disable"

ISO_ADDITIONAL_PKGS='openssh-server libxss1 lm-sensors pulseaudio pavucontrol libsigc++-2.0-0c2a libgtkmm-3.0-1 xserver-xorg-video-intel-lts-xenial ubuntu-restricted-extras gstreamer1.0-vaapi i965-va-driver sqlite3 gstreamer1.0-plugins-good gstreamer1.0-plugins-bad fail2ban xloadimage'
ISO_REMOVE_PKGS='firefox abiword gnumeric simple-scan mtpaint xfburn guvcview transmission pidgin sylpheed gnome-mplayer audacious light-locker'

if [ -f $ISO_CUSTOMIZATION_PATH/$GF_ISO_CUSTOMER/config-override.sh ]; then
    source $ISO_CUSTOMIZATION_PATH/$GF_ISO_CUSTOMER/config-override.sh
fi

INSTALL_PREFIX="/opt/gf-builddeps"

LIBUSB_VERSION="1.0.20"
LIBUSB_SHA256="cb057190ba0a961768224e4dc6883104c6f945b2bf2ef90d7da39e7c1834f7ff"
LIBUSB_DIR=$CONFIG_DIR/libusb
LIBUSB_FILENAME="libusb-$LIBUSB_VERSION.tar.bz2"
LIBUSB_TAR_URL="http://downloads.sourceforge.net/project/libusb/libusb-1.0/libusb-$LIBUSB_VERSION/$LIBUSB_FILENAME"
LIBUSB_TARGET="$LIBUSB_DIR/buildspace/"
LIBUSB_SRC_DIR="$LIBUSB_DIR/buildspace/libusb-$LIBUSB_VERSION"
