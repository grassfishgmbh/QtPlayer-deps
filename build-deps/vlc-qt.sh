#!/bin/bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $MY_DIR/../config.sh

JOBROOT=`pwd`
WD="$JOBROOT/VLC/$VLC_VERSION"
VLCQT_WD="$JOBROOT/VLC-Qt"
OLDPATH=$PATH

ARCH=$1
BLOBZIP=$2

if [ "$ARCH" == "" ]; then
    echo "ARCH (first argument) is missing"
    exit 1
fi

if [ `uname -o` == "Cygwin" ]; then
    if [ "$BLOBZIP" == "" ]; then
        echo "BLOBZIP (second argument) is missing"
        exit 1
    fi

    if [ ! -f "$BLOBZIP" ]; then
        echo "File for BLOBZIP does not exist"
        exit 1
    fi

    if [ -d $JOBROOT/install-$ARCH ]; then
        rm -rf $JOBROOT/install-$ARCH
    fi

    if [ -e VLC-Blobs-Qt-$ARCH.zip ]; then
        rm -f VLC-Blobs-Qt-$ARCH.zip
    fi
    
    rm -rf $WD
    mkdir -p $WD
    unzip $BLOBZIP -d $WD
fi


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
    
    if [ -e build-$ARCH ]; then
        rm -rf build-$ARCH
    fi
    if [ -e $JOBROOT/install-$ARCH ]; then
        rm -rf $JOBROOT/install-$ARCH
    fi
    
    mkdir build-$ARCH
    cd build-$ARCH
    
    if [ `uname -o` == "Cygwin" ]; then
        if [ $ARCH = "x86_64" ]; then
            export PATH=/cygdrive/c/Qt/5.6/msvc2013_64/bin:$OLDPATH
        else
            export PATH=/cygdrive/c/Qt/5.6/msvc2013/bin:$OLDPATH
        fi
    
        # copy dll's to include dir because cmake is batshit crazy
        cp $JOBROOT/VLC/$VLC_VERSION/bin/libvlccore.dll $JOBROOT/VLC/$VLC_VERSION/include/
        cp $JOBROOT/VLC/$VLC_VERSION/bin/libvlc.dll $JOBROOT/VLC/$VLC_VERSION/include/
        
        cmake .. -G Ninja -DCMAKE_BUILD_TYPE=Release \
            -DCMAKE_INSTALL_PREFIX="../install-$ARCH" \
            -DLIBVLC_LIBRARY=`cygpath -w -a $JOBROOT/VLC/$VLC_VERSION/bin/libvlc.lib` \
            -DLIBVLCCORE_LIBRARY=`cygpath -w -a $JOBROOT/VLC/$VLC_VERSION/bin/libvlccore.lib` \
            -DLIBVLC_INCLUDE_DIR=`cygpath -w -a $JOBROOT/VLC/$VLC_VERSION/include`
        ninja
        ninja install
    
        cp -r $JOBROOT/VLC/$VLC_VERSION/lib/* ../install-$ARCH/lib/
        mv $JOBROOT/VLC/$VLC_VERSION/bin/*.lib ../install-$ARCH/lib/
        mv $JOBROOT/VLC/$VLC_VERSION/include/vlc ../install-$ARCH/include/
    
        mv ../install-$ARCH $JOBROOT/install-$ARCH
    else
        export PATH=/opt/Qt/$QT_VERSION/gcc_64/bin:$OLDPATH
        
        cmake .. -DCMAKE_BUILD_TYPE=Release \
            -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX \
            -DLIBVLC_INCLUDE_DIR=$INSTALL_PREFIX/include
        make -j`nproc`
        sudo make install
    fi
}

create_vlc_qt_blobs_for_arch $ARCH

if [ `uname -o` == "Cygwin" ]; then
    cd $JOBROOT/install-$ARCH

    zip -y -r VLC-Blobs-Qt-$ARCH.zip *
    mv VLC-Blobs-Qt-$ARCH.zip $JOBROOT
fi
