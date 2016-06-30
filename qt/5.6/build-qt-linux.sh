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


rm -f *.zip
rm -rf qt-src
rm -f *.txt

#build essential
sudo apt-get install -y build-essential perl python git 
sudo apt-get install -y libfontconfig1-dev libfreetype6-dev libx11-dev libxext-dev libxfixes-dev libxi-dev \
						libxrender-dev libxcb1-dev libx11-xcb-dev libxcb-glx0-dev
sudo apt-get install -y "^libxcb.*" libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev
sudo apt-get install -y libgstreamer1.0-dev libgstreamer-vaapi1.0-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev \
						libgstreamer-plugins-good1.0-dev libgstreamer-plugins-bad1.0-dev 
sudo apt-get install -y libgl1-mesa-dev libegl1-mesa-dev mesa-common-dev

sudo apt-get install -y libcap-dev libbz2-dev libgcrypt11-dev libpci-dev build-essential libxcursor-dev libxcomposite-dev \
						libxdamage-dev libxrandr-dev libdrm-dev libfontconfig1-dev libxtst-dev libasound2-dev gperf \
                        libcups2-dev libpulse-dev libudev-dev libssl-dev flex bison ruby libxss-dev libatkmm-1.6-dev
sudo apt-get install -y flex bison gperf libxslt-dev ruby
sudo apt-get install -y libssl-dev libxcursor-dev libxcomposite-dev libxdamage-dev libxrandr-dev libfontconfig1-dev
sudo apt-get install -y libasound2-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev

sudo add-apt-repository -y ppa:wsnipex/vaapi
sudo apt-get update
sudo apt-get install -y libva-dev

#webengine:
sudo apt-get install -y libcap-dev libxrandr-dev libxcomposite-dev libxcursor-dev libxtst-dev libudev-dev libpci-dev libfontconfig1-dev libxss-dev

# get Qt5 main repo
git clone http://code.qt.io/cgit/qt/qt5.git --branch v$QT_VERSION qt-src

# init subrepos
cd qt-src
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
cd ..


# apply in-process-gpu & vaapi patch
cd qtwebengine-$QTWEBENGINE_VERSION/src/3rdparty/
patch -f -Np1 -i "$QT_PATCH_DIR/0001-qtwebengine-hwaccel.patch"

#enable proprietary codecs in webengine
cd ../../
grep use_proprietary_codecs .qmake.conf || echo "WEBENGINE_CONFIG+=use_proprietary_codecs">>.qmake.conf
cd ..

# build qt
#mkdir ../install
#-prefix $WORKSPACE/install 
./configure -prefix /opt/Qt/$QT_VERSION/gcc_64 -opensource -nomake examples -nomake tests -confirm-license -qt-zlib -qt-libpng -qt-libjpeg -qt-xcb
make -j`nproc`

if [ -e /opt/Qt/$QT_VERSION/ ]; then
    rm -rf /opt/Qt/$QT_VERSION
fi

sudo make install

#add lib icu
wget http://download.icu-project.org/files/icu4c/52.1/icu4c-52_1-RHEL6-x64.tgz
tar -xzf icu4c-52_1-RHEL6-x64.tgz
sudo cp -r usr/local/lib/*.so* /opt/Qt/$QT_VERSION/gcc_64/lib

# build patched WebEngine
export PATH=$QT_DIR:$PATH

mkdir build-qtwebengine-$QTWEBENGINE_VERSION
cd build-qtwebengine-$QTWEBENGINE_VERSION
qmake ../qtwebengine-$QTWEBENGINE_VERSION/qtwebengine.pro
make -j`nproc`
sudo make install
cd ..


# zip archive for dev usage
zip -y --symlinks -r ../Qt-$QT_VERSION.zip /opt/Qt/$QT_VERSION/gcc_64
cd ..


#cd qtbase
#find -type f -iname "*.o" -exec rm {} \;
#grep -e "^\[Paths" bin/qt.conf || echo -e "[Paths]\nPrefix=..">>bin/qt.conf

#zip -y --symlinks -r ../../qt.zip bin/ include/ lib/ libexec/ mkspecs/ plugins/ qml/ resources/ translations/ src/


echo "$BUILD_VERSION" > version.txt
echo `md5sum Qt-$QT_VERSION.zip` > qtframework.txt
