set PATH=C:\cygwin64\bin;%PATH%

call ..\..\config.bat

if not defined BUILD_NUMBER (set BUILD_NUMBER=1)

set BUILD_VERSION=%QT_VERSION%-%BUILD_NUMBER%
set BACK_TO_BASE=%CD%

cd ..\..\openssl
bash fetch.sh
cmd /C build.bat

cd %BACK_TO_BASE%
if "%GF_QT_IS_32_BIT_BUILD%"=="" (CALL "C:\Program Files (x86)\Microsoft Visual Studio %VisualStudioVersion%\VC\vcvarsall.bat" amd64) else (CALL "C:\Program Files (x86)\Microsoft Visual Studio %VisualStudioVersion%\VC\vcvarsall.bat" amd64_x86)

bash fetch.sh
build.bat
