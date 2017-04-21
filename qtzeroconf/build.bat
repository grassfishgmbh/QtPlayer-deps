rem bootstrap 64 bit build first

call ..\config.bat

set WORKSPACE_ROOT=%~dp0

set PATH=C:\cygwin64\bin;%PATH%
call "C:\Program Files (x86)\Microsoft Visual Studio %VisualStudioVersion%\VC\vcvarsall.bat" amd64

rem build ffmpeg
bash fetch.sh

cd buildspace

set PATH=C:\Qt\%QT_VERSION%\%VSCOMPILER%_64\bin;%PATH%
rem set INCLUDE=%cd%\..\qtav-x86_64\include;%INCLUDE%
rem set LIB=%cd%\..\qtav-x86_64\lib;%cd%\..\qtav-x86_64\bin;%LIB%

qmake CONFIG+=release
rem jom -j8
nmake
nmake install
if not exists C:\\include mkdir C:\\include\\
if exists C:\\include\\qzeroconf.h del C:\\include\\qzeroconf.h
copy qzeroconf.h C:\\include\\