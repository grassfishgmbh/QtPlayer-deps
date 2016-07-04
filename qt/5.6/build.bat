set BASEDIR=%CD%

CALL %BASEDIR%\..\..\config.bat

cd qt-src

rem build qt
cmd /C configure -prefix %QT_DIR% -opensource -nomake examples -nomake tests -confirm-license -qt-zlib -qt-libpng -qt-libjpeg -opengl dynamic
jom

if exist %QT_DIR% rd /q /s %QT_DIR%

jom install

rem build patched WebEngine
set PATH=%QT_DIR%\bin;%PATH%

mkdir build-qtwebengine-%QTWEBENGINE_VERSION%
cd build-qtwebengine-%QTWEBENGINE_VERSION%
qmake ../qtwebengine-%QTWEBENGINE_VERSION%/qtwebengine.pro
jom
jom install

rem go to qt-src
cd ..

rem to the build scripts
cd ..

bash package-win.sh

cd %CONFIG_DIR%

echo %BUILD_VERSION% > version.txt
md5sum Qt-%QT_VERSION%.zip > qtframework.txt
