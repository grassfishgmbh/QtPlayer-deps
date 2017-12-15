#!/bin/bash

set -e

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $BASEDIR
source $BASEDIR/../config.sh

if [[ -z "$QT_VERSION" ]]; then
	echo "QT_VERSION not set";
    exit -1
fi

if [[ -z "$BUILD_VERSION" ]]; then
	echo "BUILD_VERSION string not set";
    exit -1
fi


# clean up
rm -f *.zip
rm -f *.txt
if [ -n $QT_CLEAN_SRC ]; then
    git submodule deinit -f src
fi
git submodule update --init src
cd src
git submodule foreach --recursive "git clean -dfx"


QTSRCDIR=$BASEDIR/src
if [ `uname -o` == "Cygwin" ]; then
    chmod -R a+rwx $QTSRCDIR
fi

echo $BASEDIR
echo $QTSRCDIR
# init subrepos
cd $QTSRCDIR
# essential is: qtbase, qtdeclarative, qtmultimedia, qttools, qttranslations, qtdoc, qtrepotools, qtqa, qtquickcontrols
./init-repository -f --mirror git://github.com/qt/ --module-subset essential,qtsvg,qtxmlpatterns,qtlocation,qtsensors,qtconnectivity,qtwayland,qtimageformats,qtgraphicaleffects,qtserialbus,qtserialport,qtx11extras,qtwinextras,qtwebsockets,qtwebchannel,qtwebview,qtquickcontrols2,qtwebengine

# patching:
##### QTMULTIMEDIA #####
# Enable GStreamer 1.0 support
cd $QTSRCDIR/qtmultimedia
grep GST_VERSION .qmake.conf || echo "GST_VERSION=1.0">>.qmake.conf

##### QTWEBENGINE #####
# Checkout custom webengine version
cd $QTSRCDIR/qtwebengine
git checkout tags/v$QTWEBENGINE_VERSION
git submodule update --init --recursive

# apply http status code patch
echo "patching 0007-enableHttpStatusCode"
patch -f -Np1 -i "$QT_PATCH_DIR/0007-enableHttpStatusCode.patch"

echo "patching 0012-qtwebengine-hidewincrash.patch"
patch -f -Np1 -i "$QT_PATCH_DIR/0012-qtwebengine-hidewincrash.patch"

#enable proprietary codecs in webengine
cd ../../../
grep use_proprietary_codecs .qmake.conf || echo "WEBENGINE_CONFIG+=use_proprietary_codecs">>.qmake.conf

##### CHROMIUM #####
# apply in-process-gpu & vaapi patch
cd $QTSRCDIR/qtwebengine/src/3rdparty/chromium/
echo "patching 0009-qtwebengine-hwaccel"
patch -f -Np1 -i "$QT_PATCH_DIR/0009-qtwebengine-hwaccel.patch"
patch -f -Np2 -i "$QT_PATCH_DIR/0009-qtwebengine-hwaccel2.patch"
