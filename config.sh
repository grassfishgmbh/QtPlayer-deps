#!/bin/bash

CONFIG_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

QT_VERSION="5.7.0"
QTWEBENGINE_VERSION="5.7.0"
QT_DIR="/opt/Qt/$QT_VERSION/gcc_64"
QT_PATCH_DIR="$CONFIG_DIR/qt/patches"
QT_NO_CLEAN_SRC=0
PATH=$QT_DIR/bin:$PATH

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

LIBVA_VERSION="1.7.2"

GTKGLEXT_VERSION="04131c5f69070b2f194f02edd45b0622ca03793c"

NM_QT_VERSION="v5.21.0"

ISO_PLAYER_VERSION="v10.1"
BASE_OS_VERSION="16.04.1"
BASE_ISO_FILE="lubuntu-$BASE_OS_VERSION-desktop-amd64.iso"
BASE_ISO_SERIES="xenial"
BASE_OS_SHA256="1b91a43b0101e03b0890428d3e77198c0d35364cf35e38aaea2755d10ace26a7"
CREATE_ISO_DIR=$CONFIG_DIR/create-iso
ISO_BUILDSPACE=$CREATE_ISO_DIR/buildspace
ISO_CASPER_DIR=$ISO_BUILDSPACE/newIso/casper
UPDEBS_CHROOT=$ISO_BUILDSPACE/chroot
ISO_GENERIC_MODS_PATH=$CREATE_ISO_DIR/generic
ISO_CUSTOMIZATION_PATH=$CREATE_ISO_DIR/custom
UPDATE_ZIP_PATH=$CREATE_ISO_DIR/update
ISO_MOUNT=/mnt/gf_iso_mount
ISO_DESKTOP_ENVIRONMENT=lubuntu-desktop
ISO_DESKTOP_SESSION=Lubuntu
ISO_KERNEL_FLAGS="intel_pstate=disable i915.enable_execlists=0 i915.nuclear_pageflip=1 drm.vblankoffdelay=1"

ISO_ADDITIONAL_PKGS='openssh-server libxss1 lm-sensors pulseaudio pavucontrol libsigc++-2.0-0v5 libgtkmm-3.0-1v5 xserver-xorg-video-intel ubuntu-restricted-extras gstreamer1.0-vaapi i965-va-driver sqlite3 gstreamer1.0-plugins-good gstreamer1.0-plugins-bad fail2ban feh libkf5networkmanagerqt6 smartmontools'
ISO_REMOVE_PKGS='firefox abiword gnumeric simple-scan mtpaint xfburn guvcview transmission pidgin sylpheed gnome-mplayer audacious light-locker update-manager cups xfce4-power-manager network-manager-gnome'
ISO_INCLUDE_MIGRATOR=0

if [ -f $ISO_CUSTOMIZATION_PATH/$GF_ISO_CUSTOMER/config-override.sh ]; then
    source $ISO_CUSTOMIZATION_PATH/$GF_ISO_CUSTOMER/config-override.sh
fi

INSTALL_PREFIX="/opt/gf-builddeps-10-1"
NMQT_INSTALL_PREFIX="/opt/gf-libnmqt"

DBUS_VERSION="1.10.8"
DBUS_SHA256="baf3d22baa26d3bdd9edc587736cd5562196ce67996d65b82103bedbe1f0c014"
DBUS_DIR=$CONFIG_DIR/dbus
DBUS_FILENAME="dbus-$DBUS_VERSION.tar.gz"
DBUS_URL="https://dbus.freedesktop.org/releases/dbus/$DBUS_FILENAME"
DBUS_TARGET="$DBUS_DIR/buildspace/"
DBUS_SRC_DIR="$DBUS_DIR/buildspace/dbus-$DBUS_VERSION"

LIBUSB_VERSION="1.0.20"
LIBUSB_SHA256="cb057190ba0a961768224e4dc6883104c6f945b2bf2ef90d7da39e7c1834f7ff"
LIBUSB_DIR=$CONFIG_DIR/libusb
LIBUSB_FILENAME="libusb-$LIBUSB_VERSION.tar.bz2"
LIBUSB_TAR_URL="http://downloads.sourceforge.net/project/libusb/libusb-1.0/libusb-$LIBUSB_VERSION/$LIBUSB_FILENAME"
LIBUSB_TARGET="$LIBUSB_DIR/buildspace/"
LIBUSB_SRC_DIR="$LIBUSB_DIR/buildspace/libusb-$LIBUSB_VERSION"

ZLIB_VERSION="1.2.8"
ZLIB_SHA256="36658cb768a54c1d4dec43c3116c27ed893e88b02ecfcb44f2166f9c0b7f2a0d"
ZLIB_DIR=$CONFIG_DIR/zlib
ZLIB_FILENAME="zlib-$ZLIB_VERSION.tar.gz"
ZLIB_TAR_URL="http://zlib.net/$ZLIB_FILENAME"
ZLIB_TARGET="$ZLIB_DIR/buildspace/"
ZLIB_SRC_DIR="$ZLIB_DIR/buildspace/zlib-$ZLIB_VERSION"

CURL_VERSION="7.50.3"
CURL_SHA256="7b7347d976661d02c84a1f4d6daf40dee377efdc45b9e2c77dedb8acf140d8ec"
CURL_DIR=$CONFIG_DIR/curl
CURL_FILENAME="curl-$CURL_VERSION.tar.bz2"
CURL_TAR_URL="https://curl.haxx.se/download/$CURL_FILENAME"
CURL_TARGET="$CURL_DIR/buildspace/"
CURL_SRC_DIR="$CURL_DIR/buildspace/curl-$CURL_VERSION"

OXIDE_BRANCH="1.18"
