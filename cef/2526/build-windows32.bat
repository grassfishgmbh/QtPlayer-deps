set GYP_DEFINES=proprietary_codecs=1 ffmpeg_branding=Chrome
set GYP_GENERATORS=ninja,msvs-ninja
set GYP_MSVS_VERSION=2015
set CEF_BRANCH=2526

set IAMHEREDUDE=%cd%

if exist binary_distrib rmdir /s /q binary_distrib
if not exist D:\cefbuild mkdir D:\cefbuild
if not exist D:\cefbuild\automate-git.py copy automate-git.py D:\cefbuild\
if exist D:\cefbuild\overrides rmdir /s /q D:\cefbuild\overrides
cmd /C xcopy /E /I /Y patches-windows D:\cefbuild\overrides

cd D:\cefbuild
cmd /C python automate-git.py --download-dir=cef_%CEF_BRANCH% --no-build --branch=%CEF_BRANCH%

cmd /C xcopy /E /I /Y overrides\* cef_%CEF_BRANCH%\chromium\src\cef\patch\

cd cef_%CEF_BRANCH%
cd chromium\src
cd cef

cmd /C cef_create_projects.bat
cd ..

cmd /C python build/util/lastchange.py > build/util/LASTCHANGE
cmd /C python build/util/lastchange.py > build/util/LASTCHANGE.blink

ninja -C out\Release cefclient

cd cef\tools
cmd /C make_distrib.bat --ninja-build --allow-partial

cd ..

cmd /C mkdir %IAMHEREDUDE%\binary_distrib
cmd /C xcopy /E /I /Y binary_distrib %IAMHEREDUDE%\binary_distrib
