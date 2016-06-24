rem bootstrap 64 bit build first
set PATH=C:\cygwin64\bin;C:\Qt\5.6\msvc2013_64\bin;%PATH%
call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" amd64

set ARCHLESS_INCLUDE=%INCLUDE%
set ARCHLESS_LIB=%LIB%

rem build ffmpeg
rem bash ffmpeg_msvc.sh x86_64

rem fetch QtAV
bash qtav_msvc.sh x86_64

rem build QtAV
cd deps-buildspace\build-QtAV

set INCLUDE=%cd%\..\qtav-x86_64\include;%INCLUDE%
set LIB=%cd%\..\qtav-x86_64\lib;%cd%\..\qtav-x86_64\bin;%LIB%

qmake ../QtAV/QtAV.pro
jom -j8

set INCLUDE=%ARCHLESS_INCLUDE%
set LIB=%ARCHLESS_LIB%

cd ../..

rem bootstrap 32 bit build now
set PATH=C:\Qt\5.6\msvc2013\bin;%PATH%
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

set INCLUDE=%ARCHLESS_INCLUDE%
set LIB=%ARCHLESS_LIB%

cd ../..
