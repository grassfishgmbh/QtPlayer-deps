set PATH=C:\cygwin64\bin;%PATH%

call ..\..\config.bat

if not defined BUILD_NUMBER (
set BUILD_NUMBER=1
)

set BUILD_VERSION=%QT_VERSION%-%BUILD_NUMBER%

if "%GF_QT_IS_32_BIT_BUILD%"=="" (CALL "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" amd64) else (CALL "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" amd64_x86)

bash fetch.sh
build.bat
