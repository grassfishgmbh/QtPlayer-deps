rem bootstrap 64 bit build first
set PATH=C:\cygwin64\bin;C:\Qt\5.6\msvc2013_64\bin;%PATH%
call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" amd64

rem build ffmpeg
bash ffmpeg_msvc.sh x86_64

rem build QtAV
bash qtav_msvc.sh x86_64

rem bootstrap 32 bit build now
set PATH=C:\Qt\5.6\msvc2013\bin;%PATH%
call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" amd64_x86

rem build ffmpeg
bash ffmpeg_msvc.sh i686

rem build QtAV
bash qtav_msvc.sh i686
