set CONFIG_DIR=%CD%

set QT_VERSION=5.7.0
set QTWEBENGINE_VERSION=5.7.0
set QT_PATCH_DIR=%CONFIG_DIR%\qt\patches
if "%QT_SRC_DIR%"=="" (set QT_SRC_DIR=%CONFIG_DIR%\qt\5.6\qt-src)
if "%GF_QT_IS_32_BIT_BUILD%"=="" (set QT_DIR=C:\Qt\%QT_VERSION%\msvc2013_64) else (set QT_DIR=C:\Qt\%QT_VERSION%\msvc2013)
if "%GF_QT_IS_32_BIT_BUILD%"=="" (CALL "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" amd64) else (CALL "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" amd64_x86)
if "%GF_QT_IS_32_BIT_BUILD%"=="" (set OSSL_PREFIX=C:\openssl64) else (set OSSL_PREFIX=C:\openssl32)

set VLC_VERSION=2.2.1

set QTAV_DEVRELEASE=1
set QTAV_TAG=cd656df632f970f3a846809df614bed1a19a2b85
set QTAV_PATCH_DIR=%CONFIG_DIR%\qtav\patches

set FFMPEG_VERSION=2.8.6

set OPENSSL_VERSION=1.0.2h
set OPENSSL_DIR=%CONFIG_DIR%\openssl

set CURLSSL_VERSION=7.50.3
set CURLSSL_DIR=%CONFIG_DIR%\curl

set ZLIB_VERSION=1.2.8
set ZLIB_DIR=%CONFIG_DIR%\zlib
