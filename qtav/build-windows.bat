rem bootstrap amd64 build
set PATH=C:\cygwin64\bin;%PATH%
call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" amd64

rem build ffmpeg
bash ffmpeg_msvc.sh x86_64

rem build QtAV
bash build-qtav.sh x86_64
