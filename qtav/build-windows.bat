rem bootstrap 64 bit build first

call ..\config.bat

set WORKSPACE_ROOT=%cd%

set PATH=C:\cygwin64\bin;%QT_DIR%\bin;%PATH%
call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" amd64

set ARCHLESS_INCLUDE=%INCLUDE%
set ARCHLESS_LIB=%LIB%

rem build ffmpeg
bash ffmpeg_msvc.sh x86_64

rem fetch QtAV
bash qtav_msvc.sh x86_64

rem build QtAV
cd deps-buildspace\build-QtAV

set INCLUDE=%cd%\..\qtav-x86_64\include;%INCLUDE%
set LIB=%cd%\..\qtav-x86_64\lib;%cd%\..\qtav-x86_64\bin;%LIB%

qmake ../QtAV/QtAV.pro
jom -j8

rem install QtAV into specific directory
cd %WORKSPACE_ROOT%
bash qtav_installation.sh x86_64

rem reset environment variables
set INCLUDE=%ARCHLESS_INCLUDE%
set LIB=%ARCHLESS_LIB%

rem bootstrap 32 bit build now
call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" amd64_x86

rem build ffmpeg
bash ffmpeg_msvc.sh i686

rem fetch QtAV
bash qtav_msvc.sh i686

rem build QtAV
cd deps-buildspace\build-QtAV

set INCLUDE=%cd%\..\qtav-i686\include;%INCLUDE%
set LIB=%cd%\..\qtav-i686\lib;%cd%\..\qtav-i686\bin;%LIB%

qmake ../QtAV/QtAV.pro
jom -j8

rem install QtAV into specific directory
cd %WORKSPACE_ROOT%
bash qtav_installation.sh i686

set INCLUDE=%ARCHLESS_INCLUDE%
set LIB=%ARCHLESS_LIB%

rem package up the binaries
bash qtav_package_win.sh
