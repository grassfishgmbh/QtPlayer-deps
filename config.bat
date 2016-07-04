set CONFIG_DIR=%CD%

set QT_VERSION=5.6.1-1
set QTWEBENGINE_VERSION=5.7.0
set QT_PATCH_DIR=%CONFIG_DIR%\qt\patches
if "%QT_SRC_DIR%"=="" (set QT_SRC_DIR=%CONFIG_DIR%\qt\5.6\qt-src)
if "%QT_SRC_DIR_WIN%"=="" (set QT_SRC_DIR_WIN=%CONFIG_DIR%\qt\5.6\qt-src)
if "%GF_QT_IS_32_BIT_BUILD%"=="" (set QT_DIR=C:\Qt\%QT_VERSION%\msvc2013_64) else (set QT_DIR=C:\Qt\%QT_VERSION%\msvc2013)


set VLC_VERSION=2.2.1

set QTAV_DEVRELEASE=1
set QTAV_TAG=2d0dd1d1c806dba4e6ec2af58e6186df6b533c58
set QTAV_PATCH_DIR=%CONFIG_DIR%\qtav\patches

set FFMPEG_VERSION=2.8.6
