#!/bin/bash

CONFIG_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

VisualStudioVersion=14.0
VSCOMPILER=msvc2015

QT_VERSION="5.9.0"
QTWEBENGINE_VERSION="5.8.0"
QT_DIR="/opt/Qt/$QT_VERSION/gcc_64"
QT_PATCH_DIR="$CONFIG_DIR/qt/patches"
QT_NO_CLEAN_SRC=0
PATH=$QT_DIR/bin:$PATH

if [ `uname -o` != "GNU/Linux" ]; then
    VSCOMPILER="msvc2015"
    alias sudo=
    if [ "$GF_QT_IS_32_BIT_BUILD" == "" ]; then
        QT_DIR_WIN="C:\Qt\\$QT_VERSION\\${VSCOMPILER}_64"
        OSSL_PREFIX="C:\openssl64"
    else
        QT_DIR_WIN="C:\Qt\\$QT_VERSION\\${VSCOMPILER}"
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

OPENSSL_VERSION="1.0.2k"
OPENSSL_DIR=$CONFIG_DIR/openssl

LIBVA_VERSION="1.8.1"

GTKGLEXT_VERSION="04131c5f69070b2f194f02edd45b0622ca03793c"

NM_QT_VERSION="v5.21.0"

ISO_IMAGE_NAME="GrassfishPlayerImage"
GF_DEFAULT_HOSTNAME="GrassfishPlayer"
ISO_PRESCRIPT="pre-iot.sh"
ISO_POSTSCRIPT="post.sh"
ISO_PLAYER_VERSION="v10.1"
BASE_OS_VERSION="16.04.2"
BASE_ISO_FILE="lubuntu-$BASE_OS_VERSION-desktop-amd64.iso"
BASE_ISO_SERIES="xenial"
BASE_OS_SHA256="84ad81825c66b182413007f20d047d34ac7f528079857399a7b529a93edcddfc"
CREATE_ISO_DIR=$CONFIG_DIR/create-iso
ISO_BUILDSPACE=$CREATE_ISO_DIR/buildspace
ISO_RELEASEDIR=$CREATE_ISO_DIR/released
ISO_CASPER_DIR=$ISO_BUILDSPACE/newIso/casper
UPDEBS_CHROOT=$ISO_BUILDSPACE/chroot
ISO_GENERIC_MODS_PATH=$CREATE_ISO_DIR/generic
ISO_CUSTOMIZATION_PATH=$CREATE_ISO_DIR/custom
UPDATE_ZIP_PATH=$CREATE_ISO_DIR/update
ISO_MOUNT=/mnt/gf_iso_mount
ISO_DESKTOP_ENVIRONMENT=lubuntu-desktop
ISO_DESKTOP_SESSION=Lubuntu
ISO_KERNEL_FLAGS="intel_pstate=disable i915.enable_psr=0 i915.enable_fbc=0 i915.enable_execlists=0 i915.nuclear_pageflip=1 drm.vblankoffdelay=1 nogpumanager fsck.mode=force fsck.repair=yes"
ISO_DEFAULT_TIMEZONE="Europe\/Vienna"
ISO_ADDITIONAL_PKGS='openssh-server libxss1 lm-sensors pulseaudio pavucontrol libsigc++-2.0-0v5 libgtkmm-3.0-1v5 ubuntu-restricted-extras gstreamer1.0-vaapi i965-va-driver sqlite3 libxvidcore4 gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly gstreamer1.0-plugins-bad gstreamer1.0-alsa gstreamer1.0-fluendo-mp3 gstreamer1.0-libav fail2ban feh libkf5networkmanagerqt6 smartmontools tlp dconf-cli mesa-utils libvdpau-va-gl1 gstreamer0.10-alsa avahi-utils mpv gdisk dialog'
ISO_REMOVE_PKGS='firefox abiword gnumeric simple-scan mtpaint xfburn guvcview transmission pidgin sylpheed gnome-mplayer audacious light-locker update-manager ubuntu-release-upgrader-core update-manager-core cups xfce4-power-manager alsamixergui transmission-gtk lubuntu-software-center usb-creator-gtk xpad bluez blueman ntp'
ISO_INCLUDE_MIGRATOR=0
ISO_DEFAULT_SYSTEMDTARGET="gf-install.target"
GF_DEFAULT_SYSTEMDTARGET="graphical.target"
GF_IMAGE_LABEL="GrassfishPlayer"

if [ -f $ISO_CUSTOMIZATION_PATH/$GF_ISO_CUSTOMER/config-override.sh ]; then
    source $ISO_CUSTOMIZATION_PATH/$GF_ISO_CUSTOMER/config-override.sh
fi

if [ "$GF_BUILD_OS" == "android" ]; then
    ANDROID_NDK_ROOT="/opt/android/ndk-bundle"
    export ANDROID_NDK_ROOT
    PATH=/opt/android/Qt/5.8/android_armv7/bin:${PATH}
    export PATH
    INSTALL_PREFIX="/opt/gfandroid/10.2"
else
    INSTALL_PREFIX="/opt/gfbuild/10.2"
fi
NMQT_INSTALL_PREFIX="/opt/gf-libnmqt"

DBUS_VERSION="1.10.8"
DBUS_SHA256="baf3d22baa26d3bdd9edc587736cd5562196ce67996d65b82103bedbe1f0c014"
DBUS_DIR=$CONFIG_DIR/dbus
DBUS_FILENAME="dbus-$DBUS_VERSION.tar.gz"
DBUS_URL="https://dbus.freedesktop.org/releases/dbus/$DBUS_FILENAME"
DBUS_TARGET="$DBUS_DIR/buildspace/"
DBUS_SRC_DIR="$DBUS_DIR/src"

LIBUSB_VERSION="1.0.20"
LIBUSB_SHA256="cb057190ba0a961768224e4dc6883104c6f945b2bf2ef90d7da39e7c1834f7ff"
LIBUSB_DIR=$CONFIG_DIR/libusb
LIBUSB_FILENAME="libusb-$LIBUSB_VERSION.tar.bz2"
LIBUSB_TAR_URL="http://downloads.sourceforge.net/project/libusb/libusb-1.0/libusb-$LIBUSB_VERSION/$LIBUSB_FILENAME"
LIBUSB_TARGET="$LIBUSB_DIR/buildspace/"
LIBUSB_SRC_DIR="$LIBUSB_DIR/src"

ZLIB_VERSION="1.2.11"
ZLIB_SHA256="c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1"
ZLIB_DIR=$CONFIG_DIR/zlib
ZLIB_FILENAME="zlib-$ZLIB_VERSION.tar.gz"
#ZLIB_TAR_URL="http://zlib.net/$ZLIB_FILENAME"
ZLIB_TAR_URL="https://download.videolan.org/contrib/zlib/$ZLIB_FILENAME"
ZLIB_TARGET="$ZLIB_DIR/buildspace/"
ZLIB_SRC_DIR="$ZLIB_DIR/src"

CURL_VERSION="7.50.3"
CURL_SHA256="7b7347d976661d02c84a1f4d6daf40dee377efdc45b9e2c77dedb8acf140d8ec"
CURL_DIR=$CONFIG_DIR/curl
CURL_FILENAME="curl-$CURL_VERSION.tar.bz2"
CURL_TAR_URL="https://curl.haxx.se/download/$CURL_FILENAME"
CURL_TARGET="$CURL_DIR/buildspace/"
CURL_SRC_DIR="$CURL_DIR/src"

PROTOBUF_VERSION="3.1.0"
PROTOBUF_SHA256="51ceea9957c875bdedeb1f64396b5b0f3864fe830eed6a2d9c066448373ea2d6"
PROTOBUF_DIR=$CONFIG_DIR/protobuf
PROTOBUF_FILENAME="protobuf-cpp-$PROTOBUF_VERSION.tar.gz"
PROTOBUF_TAR_URL="https://github.com/google/protobuf/releases/download/v${PROTOBUF_VERSION}/$PROTOBUF_FILENAME"
PROTOBUF_TARGET="$PROTOBUF_DIR/buildspace/"
PROTOBUF_SRC_DIR="$PROTOBUF_DIR/src"

QTZEROCONF_VERSION="4e2d636323e7b5692bfd39fb0e564d198289ece8"
QTZEROCONF_DIR=$CONFIG_DIR/qtzeroconf
QTZEROCONF_TARGET="$QTZEROCONF_DIR/buildspace/"
QTZEROCONF_SRC_DIR="$QTZEROCONF_DIR/src"

OXIDE_BRANCH="1.18"

QBS_VERSION="1.7.0"

LIRIOSWAYLAND_VERSION="6564c9f6ce98d16c759c562a8a88eee4f1f899eb"
LIRIOSWAYLAND_DIR=$CONFIG_DIR/lirios-wayland
LIRIOSWAYLAND_TARGET="$LIRIOSWAYLAND_DIR/buildspace/"
LIRIOSWAYLAND_SRC_DIR="$LIRIOSWAYLAND_DIR/src"

LIBQTXDG_VERSION="2.0.0"
LIBQTXDG_DIR=$CONFIG_DIR/libqtxdg
LIBQTXDG_TARGET="$LIBQTXDG_DIR/buildspace/"
LIBQTXDG_SRC_DIR="$LIBQTXDG_DIR/src"
