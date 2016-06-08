#!/bin/bash

if [ -z "$VERSION" ]; then
    VERSION="2.2.3"
fi

JOBROOT=`pwd`
WD="$JOBROOT/VLC/$VERSION"
VLCQT_WD="$JOBROOT/VLC-Qt"
OLDPATH=$PATH

ARCH=$1
BLOBZIP=$2

if [ "$ARCH" == "" ]; then
    echo "ARCH (first argument) is missing"
fi

if [ "$BLOBZIP" == "" ]; then
    echo "BLOBZIP (second argument) is missing"
fi

if [ ! -f "$BLOBZIP" ]; then
    echo "File for BLOBZIP does not exist"
fi

if [ -e VLC-Blobs-Qt.zip ]; then
    rm -f VLC-Blobs-Qt.zip
fi

rm -rf $WD
mkdir -p $WD
unzip $BLOBZIP -d $WD

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
        export PATH=/cygdrive/c/Qt/5.6/msvc2013_64/bin:$OLDPATH
        GENERATOR="Ninja"
    else
        MACHINE="/MACHINE:x86"
        export PATH=/cygdrive/c/Qt/5.6/msvc2013/bin:$OLDPATH
        GENERATOR="Ninja"
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
        -DCMAKE_INSTALL_PREFIX="../install-$ARCH/msvc64" \
        -DLIBVLC_LIBRARY="$JOBROOT/VLC/$VERSION/$ARCH/bin/libvlc.lib" \
        -DLIBVLCCORE_LIBRARY="$JOBROOT/VLC/$VERSION/$ARCH/bin/libvlccore.lib" \
        -DLIBVLC_INCLUDE_DIR="$JOBROOT/VLC/$VERSION/$ARCH/include"
    #cmake --build .
    ninja
    ninja install
}

create_vlc_qt_blobs_for_arch $ARCH
cd $JOBROOT

zip -y -r VLC-Blobs-Qt.zip VLC
