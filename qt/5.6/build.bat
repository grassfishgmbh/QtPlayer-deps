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
cd ..

rem zip archive for dev usage
zip -y --symlinks -r ../Qt-%QT_VERSION%.zip %QT_DIR%
cd ..

echo %BUILD_VERSION% > version.txt
md5sum Qt-%QT_VERSION%.zip > qtframework.txt
