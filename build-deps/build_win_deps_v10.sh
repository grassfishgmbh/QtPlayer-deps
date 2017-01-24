#!/bin/bash

set -e

source ../config.sh

function build_vlc_for_target_arch () {
    ARCH=$1
    TRIPLET=$2
    
    if [ -e $BUILD_ROOT/vlc-$ARCH.zip ]; then
        rm -f $BUILD_ROOT/vlc-$ARCH.zip
    fi
    
    mkdir -p contrib/$ARCH
    
    wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/libkate/libkate-0.4.1.tar.gz -P contrib/tarballs/
    wget http://www.ijg.org/files/jpegsrc.v9a.tar.gz -P contrib/tarballs/
    wget http://downloads.sourceforge.net/openjpeg.mirror/openjpeg-1.5.0.tar.gz -P contrib/tarballs/
    wget http://pkgs.fedoraproject.org/repo/pkgs/libvpx/libvpx-v1.3.0.tar.bz2/14783a148872f2d08629ff7c694eb31f/libvpx-v1.3.0.tar.bz2 -P contrib/tarballs/
    
    cd contrib/$ARCH
    ../bootstrap --host=$TRIPLET --disable-gpl --disable-qt4 --disable-qt \
                                 --disable-bluray --disable-libgcrypt \
                                 --disable-libssh2 --disable-ssh2 \
                                 --disable-gcrypt --disable-gnutls \
                                 --disable-qt5 --disable-lua \
                                 --disable-taglib --disable-projectM \
                                 --disable-vncserver --disable-gsm \
                                 --disable-ass --disable-harfbuzz \
                                 --disable-fontconfig --disable-freetype2 \
                                 --disable-gme
    make fetch
    #sed -i "s/--enable-static --disable-shared/--disable-static --enable-shared/g" ../src/ffmpeg/rules.mak
    make -j`nproc`

    if [ -e ../$TRIPLET/bin/moc ]; then
        rm -f ../$TRIPLET/bin/moc
    fi

    if [ -e ../$TRIPLET/bin/uic ]; then
        rm -f ../$TRIPLET/bin/uic
    fi

    if [ -e ../$TRIPLET/bin/rcc ]; then
        rm -f ../$TRIPLET/bin/rcc
    fi

    cd $ORIGINAL_PWD

    ./bootstrap
    if [ ! -e $ARCH ]; then
        mkdir $ARCH
    fi 
    pwd
    cd $ARCH

    export PKG_CONFIG_LIBDIR=$ORIGINAL_PWD/contrib/$TRIPLET/lib/pkgconfig
    cd $PKG_CONFIG_LIBDIR/../
    
    if [ ! -e libswscale.a ]; then
        ln -s libswscale.dll.a libswscale.a
    fi
    
    if [ ! -e libavutil.a ]; then
        ln -s libavutil.dll.a libavutil.a
    fi
    
    if [ ! -e libavformat.a ]; then
        ln -s libavformat.dll.a libavformat.a
    fi
    
    if [ ! -e libavcodec.a ]; then
        ln -s libavcodec.dll.a libavcodec.a
    fi
    
    cd $ORIGINAL_PWD
    cd $ARCH
    
    ../extras/package/win32/configure.sh --host=$TRIPLET --disable-gtk \
                                     --disable-livedotcom --disable-skins \
                                     --disable-skins2 --disable-kde \
                                     --disable-qt --disable-wxwindows \
                                     --disable-ncurses --enable-release \
                                     --disable-lua --disable-mad --disable-a52 \
                                     --disable-libgcrypt --disable-update-check \
                                     --disable-x265 --disable-taglib \
                                     --disable-gnutls --disable-sid --disable-gme \
                                     --disable-dvdread --disable-faad \
                                     --disable-dca --disable-x264

    # WUBBA LUBBA DUB DUUUUB
    make -j`nproc`

    make install
    
    # generate supporting lib file
    cd _win32
    $TRIPLET-dlltool -D libvlccore.dll -l bin/libvlccore.lib -d ../src/.libs/libvlccore.dll.def
    $TRIPLET-dlltool -D libvlc.dll -l bin/libvlc.lib -d ../lib/.libs/libvlc.dll.def
    
    # archive
    zip -r vlc-$ARCH.zip *
    mv vlc-$ARCH.zip $BUILD_ROOT/
    
    cd $ORIGINAL_PWD
}

function build_shared_qt_for_target_arch() {
    ARCH=$1
    TRIPLET=$2
    
    cd $BUILD_ROOT
    echo "Fetching MXE for shared Qt ($ARCH)..."
    git clone https://github.com/mxe/mxe.git mxe-shared-$ARCH
    cd mxe-shared-$ARCH
    echo "Building Qt (shared, $ARCH)"
    
    make qt5 MXE_TARGETS="$TRIPLET.shared"
    echo "Done building Qt (shared, $ARCH)"
}

. /etc/os-release

if [ "$VERSION_ID" != "14.04" ]; then
    echo "This build script assumes a working Ubuntu trusty installation. Bailing."
    exit 1
fi

echo "Get dependencies..."
sudo dpkg --add-architecture i386
sudo apt-get install software-properties-common python-software-properties -y
sudo add-apt-repository ppa:ubuntu-wine/ppa -y
sudo apt-get update

sudo apt-get install -y gcc-mingw-w64-i686 g++-mingw-w64-i686 mingw-w64-tools \
                gcc-mingw-w64-x86-64 g++-mingw-w64-x86-64 mingw-w64-tools \
                mingw32 mingw32-binutils mingw-w64 \
                subversion yasm cvs cmake ragel git wine1.8-dev dh-autoreconf


echo "Installing dependencies for cross-building Qt for Windows (static)"
sudo apt-get install -y \
    autoconf automake autopoint bash bison bzip2 flex gettext\
    git g++ gperf intltool libffi-dev libgdk-pixbuf2.0-dev \
    libtool libltdl-dev libssl-dev libxml-parser-perl make \
    openssl p7zip-full patch perl pkg-config python ruby scons \
    sed unzip wget xz-utils g++-multilib libc6-dev-i386


echo "Fix cross-compiling wrapper..."

sudo cp ./pkg-config-crosswrapper-trusty-fixed /usr/share/pkg-config-crosswrapper
sudo chown root:root /usr/share/pkg-config-crosswrapper
sudo chmod 755 /usr/share/pkg-config-crosswrapper

if [ -d deps-buildspace-win ]; then
    sudo rm -rf deps-buildspace-win
fi
mkdir deps-buildspace-win

cd deps-buildspace-win
BUILD_ROOT=`pwd`

echo "Fetch VLC source code..."

if [ ! -e vlc-$VLC_VERSION.tar.xz ]; then
    wget http://get.videolan.org/vlc/$VLC_VERSION/vlc-$VLC_VERSION.tar.xz
fi

echo "Building VLC..."

tar xvf vlc-$VLC_VERSION.tar.xz

# APPLY NEEDED PATCHES
#cd vlc-$VLC_VERSION
#patch -p1 < ../../libvlc_vmem_visible_rect.patch
#patch -p1 < ../../libvlc_keep_aspect_info.patch
#cd -

cd vlc-$VLC_VERSION

#git clone http://git.videolan.org/git/vlc.git vlc
#cd vlc

ORIGINAL_PWD=`pwd`

# NOTE: Disabled as of 24.01.2017 due to VLC/QtAV ffmpeg mismatch
#build_vlc_for_target_arch "win64" "x86_64-w64-mingw32"
#build_vlc_for_target_arch "win32" "i686-w64-mingw32"
#echo "Building VLC DONE!"

cd $BUILD_ROOT


echo "Fetching MXE for static Qt..."
git clone https://github.com/mxe/mxe.git
cd mxe
echo "Building Qt (static)"
make qtbase
make qtwinextras
make qttools
echo "Building Qt DONE!"

cd $BUILD_ROOT

echo "Fetching Qt Installer Framework"
git clone git://code.qt.io/installer-framework/installer-framework.git -b 2.0

export PATH=$BUILD_ROOT/mxe/usr/bin:$PATH
sed -i "s/QTPLUGIN.qmltooling = -/\!win32:QTPLUGIN.qmltooling = -/g" installer-framework/src/sdk/sdk.pro
mkdir installer-framework-build
cd installer-framework-build

echo "Building Qt Installer Framework"

i686-w64-mingw32.static-qmake-qt5 ../installer-framework/installerfw.pro
make
make install

zip -r QtIFW_win32.zip bin lib

if [ -e $BUILD_ROOT/QtIFW_win32.zip ]; then
    rm -f $BUILD_ROOT/QtIFW_win32.zip
fi

mv QtIFW_win32.zip $BUILD_ROOT/

echo "DONE building Qt Installer Framework"

#build_shared_qt_for_target_arch "win64" "x86_64-w64-mingw32"
#build_shared_qt_for_target_arch "win32" "i686-w64-mingw32"

echo "Build complete!"
exit 0
