set BASEDIR=%CD%

CALL %BASEDIR%\..\config.bat

if "%GF_QT_IS_32_BIT_BUILD%"=="" (set OSSL_TARGET=VC-WIN64A & set CONFIG_BATCH=do_win64a) else (set OSSL_TARGET=VC-WIN32 no-asm & set CONFIG_BATCH=do_ms)
if "%GF_QT_IS_32_BIT_BUILD%"=="" (CALL "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" amd64) else (CALL "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" amd64_x86)
if "%GF_QT_IS_32_BIT_BUILD%"=="" (set OSSL_PREFIX=C:\openssl64) else (set OSSL_PREFIX=C:\openssl32)
cd src

perl Configure enable-shared %OSSL_TARGET% --prefix=%OSSL_PREFIX%
set MAKEFLAGS=
set CXXFLAGS=
cmd /C ms\%CONFIG_BATCH%
nmake -f ms\ntdll.mak
nmake -f ms\ntdll.mak install
