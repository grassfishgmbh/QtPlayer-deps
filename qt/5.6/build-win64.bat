set PATH=C:\cygwin64\bin;%PATH%

if "%GF_QT_IS_32_BIT_BUILD%"=="" (CALL "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" amd64) else (CALL "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" amd64_x86)

bash fetch.sh
call build.bat
