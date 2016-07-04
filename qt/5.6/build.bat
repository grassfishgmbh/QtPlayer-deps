set BASEDIR=%CD%

CALL %BASEDIR%\..\..\config.bat

cd %QT_SRC_DIR%

rem build qt
cmd /C configure -prefix %QT_DIR% -opensource -nomake examples -nomake tests -confirm-license -qt-zlib -qt-libpng -qt-libjpeg -opengl dynamic
jom

if exist %QT_DIR% rd /q /s %QT_DIR%

jom install

rem build patched WebEngine
set PATH=%QT_DIR%\bin;%PATH%

cd %CONFIG_DIR%\qt\5.6

bash package-win.sh

cd %CONFIG_DIR%

echo %BUILD_VERSION% > version.txt
md5sum Qt-%QT_VERSION%.zip > qtframework.txt
