#!/bin/bash

if [ -z "$VERSION" ]; then
    VERSION="2.2.3"
fi

JOBROOT=`pwd`
WD="$JOBROOT/VLC/$VERSION"

DUMPBIN_BIN="dumpbin"
LIB_BIN="lib"


rm -rf $WD
rm -f VLC-Blobs.zip
mkdir -p $WD



function create_vlc_blobs_for_arch () {
    ARCH=$1
    SRCZIP=$2
    
    cd $WD
    unzip $JOBROOT/$SRCZIP
    mkdir $ARCH 
    cd $ARCH

    cp ../_win32/bin/libvlc* ./
    cp -r ../_win32/lib/vlc/plugins plugins
    cp -r ../_win32/include include
    
    rm -rf ../_win32
    
    MACHINE="/MACHINE:x86"
    if [ $ARCH = "x86_64" ]; then
        MACHINE="/MACHINE:x64"
    fi
    
    # export libvlccore symbols
    $DUMPBIN_BIN /exports libvlccore.dll > libvlccore.def.tmp
    rm -f libvlccore.def
    echo "EXPORTS" > libvlccore.def
    cat libvlccore.def.tmp | awk '/libvlc\_/ {print $4;}' >> libvlccore.def
    rm libvlccore.def.tmp
    $LIB_BIN /def:libvlccore.def /out:libvlccore.lib $MACHINE
    
    # export libvlc symbols
    $DUMPBIN_BIN /exports libvlc.dll > libvlc.def.tmp
    rm -f libvlc.def
    echo "EXPORTS" > libvlc.def
    cat libvlc.def.tmp | awk '/libvlc\_/ {print $4;}' >> libvlc.def
    rm libvlc.def.tmp
    $LIB_BIN /def:libvlc.def /out:libvlc.lib $MACHINE
}

create_vlc_blobs_for_arch "i686" "vlc-win32.zip"
create_vlc_blobs_for_arch "x86_64" "vlc-win64.zip"
cd $JOBROOT

zip -y -r VLC-Blobs.zip VLC
