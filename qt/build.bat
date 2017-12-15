set BASEDIR=%CD%

CALL %BASEDIR%\..\..\config.bat
cd %QT_SRC_DIR%

rem build qt
if "%GF_QT_IS_32_BIT_BUILD%"=="" (set OSSL_PREFIX=C:\openssl64) else (set OSSL_PREFIX=C:\openssl32)
set LIB=%OSSL_PREFIX%\lib;%OSSL_PREFIX%\bin;%OSSL_PREFIX%;%LIB%
set INCLUDE=%OSSL_PREFIX%;%OSSL_PREFIX%\include;%OSSL_PREFIX%\inc32;%INCLUDE%
rem set OPENSSL_LIBS=-L%OSSL_PREFIX%\lib -llibeay32
nmake clean
jom clean
cmd /C configure -prefix %QT_DIR% -opensource -nomake examples -nomake tests -confirm-license -qt-zlib -qt-libpng -qt-libjpeg -opengl dynamic -wmf-backend
jom

if exist %QT_DIR% rd /q /s %QT_DIR%

jom install

rem build patched WebEngine
set PATH=%QT_DIR%\bin;%PATH%

cd %BASEDIR%

bash package-win.sh
