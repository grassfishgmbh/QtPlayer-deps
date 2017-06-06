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

cd $QT_SRC_DIR

OPENGL_IMPLEMENTATION=desktop
if [ `uname -o` != "GNU/Linux" ]; then
    OPENGL_IMPLEMENTATION=dynamic
fi

# build qt
#mkdir ../install
#-prefix $WORKSPACE/install 
./configure -prefix /opt/Qt/$QT_VERSION/gcc_64 -opensource -nomake examples -nomake tests -confirm-license -qt-zlib -qt-libpng -qt-libjpeg -qt-xcb -qt-pcre -gstreamer 1.0 -qt-harfbuzz -opengl $OPENGL_IMPLEMENTATION
make -j`nproc`

if [ -e /opt/Qt/$QT_VERSION/ ]; then
    sudo rm -rf /opt/Qt/$QT_VERSION
fi

sudo make install

#add lib icu
wget http://download.icu-project.org/files/icu4c/55.1/icu4c-55_1-RHEL6-x64.tgz
tar -xzf icu4c-55_1-RHEL6-x64.tgz
sudo cp -r usr/local/lib/*.so* /opt/Qt/$QT_VERSION/gcc_64/lib

# zip archive for dev usage
zip -y --symlinks -r ../Qt-$QT_VERSION.zip /opt/Qt/$QT_VERSION/gcc_64
cd ..


#cd qtbase
#find -type f -iname "*.o" -exec rm {} \;
#grep -e "^\[Paths" bin/qt.conf || echo -e "[Paths]\nPrefix=..">>bin/qt.conf

#zip -y --symlinks -r ../../qt.zip bin/ include/ lib/ libexec/ mkspecs/ plugins/ qml/ resources/ translations/ src/


echo "$BUILD_VERSION" > version.txt
echo `md5sum Qt-$QT_VERSION.zip` > qtframework.txt
