#!/bin/bash

if [ -z "$VERSION" ]; then
    VERSION="2.2.3"
fi

JOBROOT=`pwd`
WD="$JOBROOT/VLC/$VERSION"
VLCQT_WD="$JOBROOT/VLC-Qt"

if [ -e VLC-Blobs-Qt.zip ]; then
    rm -f VLC-Blobs-Qt.zip
fi

rm -rf $WD
unzip VLC-Blobs.zip -d $JOBROOT
mkdir -p $WD

if [ -e $VLCQT_WD ]; then
    rm -rf $VLCQT_WD
fi 

mkdir $VLCQT_WD
cd $VLCQT_WD

if [ ! -e vlc-qt ]; then
    git clone git://github.com/vlc-qt/vlc-qt.git vlc-qt
    cd vlc-qt
    git checkout 0c235025eb3160c633799dc8430261b6c2a6949d
    git submodule init
    git submodule update
    cd ..
fi

cd $JOBROOT

function create_vlc_qt_blobs_for_arch () {
    ARCH=$1
    
    cd $VLCQT_WD/vlc-qt
    
    if [ $ARCH = "x86_64" ]; then
        MACHINE="/MACHINE:x64"
        export PATH=/cygdrive/c/Qt/5.6/msvc2013_64/bin:$PATH
        GENERATOR="Visual Studio 12 Win64"
    else
        MACHINE="/MACHINE:x86"
        export PATH=/cygdrive/c/Qt/5.6/msvc2013/bin:$PATH
        GENERATOR="Visual Studio 12"
    fi
    
    if [ -e build-$ARCH ]; then
        rm -rf build-$ARCH
    fi
    if [ -e install-$ARCH ]; then
        rm -rf install-$ARCH
    fi
    
    mkdir build-$ARCH
    mkdir install-$ARCH
    cd build-$ARCH
    cmake .. -G "$GENERATOR" -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX="../install-$ARCH/" \
        -DLIBVLC_LIBRARY=`cygpath -w -a $JOBROOT/VLC/$VERSION/$ARCH/libvlc.lib` \
        -DLIBVLCCORE_LIBRARY=`cygpath -w -a $JOBROOT/VLC/$VERSION/libvlccore.lib` \
        -DLIBVLC_INCLUDE_DIR=`cygpath -w -a $JOBROOT/VLC/$VERSION/include`
    cmake --build .
}

create_vlc_qt_blobs_for_arch "i686"
create_vlc_qt_blobs_for_arch "x86_64"
cd $JOBROOT

zip -y -r VLC-Blobs-Qt.zip VLC
