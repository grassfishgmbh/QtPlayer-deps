#!/bin/bash

set -e

BASEDIR=$(dirname "$0")

source $BASEDIR/../../config.sh

if [[ -z "$QT_VERSION" ]]; then
	echo "QT_VERSION not set";
    exit -1
fi

if [[ -z "$BUILD_VERSION" ]]; then
	echo "BUILD_VERSION string not set";
    exit -1
fi


CLONE_QT_SRC=qt-src
if [ `uname -o` == "GNU/Linux" ]; then
    bash prepare.sh
fi

if [ `uname -o` == "Cygwin" ]; then
    CLONE_QT_SRC=`cygpath -a $QT_SRC_DIR`
fi

# clean up
rm -f *.zip
if [ -e $CLONE_QT_SRC ]; then
    rm -rf $CLONE_QT_SRC
fi
rm -f *.txt

# get Qt5 main repo
git clone http://code.qt.io/cgit/qt/qt5.git --branch v$QT_VERSION $CLONE_QT_SRC

# init subrepos
cd $CLONE_QT_SRC
#perl init-repository --module-subset=default,-qtwebkit-examples,-qt3d,-qtactiveqt,-qtandroidextras,-qtcanvas3d,-qtpurchasing,-qtenginio,-qtmacextras,-qtpim,-qtfeedback,qtwebkit
git submodule init qtbase qtconnectivity qtdeclarative qtdoc qtgraphicaleffects qtimageformats qtlocation qtmultimedia qtqa 
git submodule init qtquickcontrols qtquickcontrols2 qtrepotools qtscript qtsensors  qtserialbus qtserialport qtsvg qttools
git submodule init qttranslations qtwayland qtwebchannel qtwebkit qtwebsockets qtwebview qtwinextras qtx11extras qtxmlpatterns
git submodule update

# init subsubrepos
cd qtxmlpatterns; git submodule update --init; cd ..
cd qtdeclarative; git submodule update --init; cd ..

# Enable GStreamer 1.0 support
cd qtmultimedia
grep GST_VERSION .qmake.conf || echo "GST_VERSION=1.0">>.qmake.conf
cd ..

# apply patch: protection against accessing destroyed QDBusConnectionManager
cd qtbase
patch -f -Np1 -i "$QT_PATCH_DIR/0006-dbus-connectionmanager-destroy.patch"
cd ..

# independently pull QtWebEngine based on the version defined in config.sh
if [ -e qtwebengine-$QTWEBENGINE_VERSION ]; then
    rm -rf qtwebengine-$QTWEBENGINE_VERSION
fi

git clone https://github.com/qt/qtwebengine.git qtwebengine-$QTWEBENGINE_VERSION
cd qtwebengine-$QTWEBENGINE_VERSION
git checkout tags/v$QTWEBENGINE_VERSION
git submodule update --init --recursive

# apply proxy patch
patch -f -Np1 -i "$QT_PATCH_DIR/0002-disable-proxy-for-localhost.patch"

# apply webchannel transport patch
patch -f -Np1 -i "$QT_PATCH_DIR/0005-qtwebengine-5.7-reload-channel.patch"
cd ..


# apply in-process-gpu & vaapi patch
cd qtwebengine-$QTWEBENGINE_VERSION/src/3rdparty/
patch -f -Np1 -i "$QT_PATCH_DIR/0001-qtwebengine-hwaccel.patch"

#enable proprietary codecs in webengine
cd ../../
grep use_proprietary_codecs .qmake.conf || echo "WEBENGINE_CONFIG+=use_proprietary_codecs">>.qmake.conf
cd ..

