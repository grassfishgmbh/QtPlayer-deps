set CONFIG_DIR=%~dp0

set VisualStudioVersion=14.0
set VSCOMPILER=msvc2015

set QT_VERSION=5.9.0
set QTWEBENGINE_VERSION=5.8.0
set QT_PATCH_DIR=%CONFIG_DIR%\qt\patches
if "%QT_SRC_DIR%"=="" (set QT_SRC_DIR=%CONFIG_DIR%\qt\5.6\qt-src)
if "%GF_QT_IS_32_BIT_BUILD%"=="" (set QT_DIR=C:\Qt\%QT_VERSION%\%VSCOMPILER%_64) else (set QT_DIR=C:\Qt\%QT_VERSION%\%VSCOMPILER%)
if "%GF_QT_IS_32_BIT_BUILD%"=="" (CALL "C:\Program Files (x86)\Microsoft Visual Studio %VisualStudioVersion%\VC\vcvarsall.bat" amd64) else (CALL "C:\Program Files (x86)\Microsoft Visual Studio %VisualStudioVersion%\VC\vcvarsall.bat" amd64_x86)
if "%GF_QT_IS_32_BIT_BUILD%"=="" (set OSSL_PREFIX=C:\openssl64) else (set OSSL_PREFIX=C:\openssl32)

set VLC_VERSION=2.2.1

set QTAV_DEVRELEASE=1
set QTAV_TAG=51fb47577a8c8bc681faa2c27180a1c65671c078
set QTAV_PATCH_DIR=%CONFIG_DIR%\qtav\patches

set FFMPEG_VERSION=2.8.6

set OPENSSL_VERSION=1.0.2k
set OPENSSL_DIR=%CONFIG_DIR%\openssl

set CURLSSL_VERSION=7.50.3
set CURLSSL_DIR=%CONFIG_DIR%\curl

set ZLIB_VERSION=1.2.8
set ZLIB_DIR=%CONFIG_DIR%\zlib

set QTZEROCONF_VERSION=4e2d636323e7b5692bfd39fb0e564d198289ece8
set QTZEROCONF_DIR=%CONFIG_DIR%/qtzeroconf
set QTZEROCONF_TARGET=%QTZEROCONF_DIR%/buildspace/
set QTZEROCONF_SRC_DIR=%QTZEROCONF_DIR%/src-qtzeroconf-%QTZEROCONF_VERSION%
