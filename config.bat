set CONFIG_DIR=%~dp0

set VisualStudioVersion=14.0
set VSCOMPILER=msvc2015

set QT_VERSION=5.7.1
set QTWEBENGINE_VERSION=5.7.1
set QT_PATCH_DIR=%CONFIG_DIR%\qt\patches
if "%QT_SRC_DIR%"=="" (set QT_SRC_DIR=%CONFIG_DIR%\qt\5.6\qt-src)
if "%GF_QT_IS_32_BIT_BUILD%"=="" (set QT_DIR=C:\Qt\%QT_VERSION%\%VSCOMPILER%_64) else (set QT_DIR=C:\Qt\%QT_VERSION%\%VSCOMPILER%)
if "%GF_QT_IS_32_BIT_BUILD%"=="" (CALL "C:\Program Files (x86)\Microsoft Visual Studio %VisualStudioVersion%\VC\vcvarsall.bat" amd64) else (CALL "C:\Program Files (x86)\Microsoft Visual Studio %VisualStudioVersion%\VC\vcvarsall.bat" amd64_x86)
if "%GF_QT_IS_32_BIT_BUILD%"=="" (set OSSL_PREFIX=C:\openssl64) else (set OSSL_PREFIX=C:\openssl32)

set VLC_VERSION=2.2.1

set QTAV_DEVRELEASE=1
set QTAV_TAG=7e0c68dd43bbbb0c24712397f67c24e401065a2c
set QTAV_PATCH_DIR=%CONFIG_DIR%\qtav\patches

set FFMPEG_VERSION=2.8.6

set OPENSSL_VERSION=1.0.2j
set OPENSSL_DIR=%CONFIG_DIR%\openssl

set CURLSSL_VERSION=7.50.3
set CURLSSL_DIR=%CONFIG_DIR%\curl

set ZLIB_VERSION=1.2.8
set ZLIB_DIR=%CONFIG_DIR%\zlib
