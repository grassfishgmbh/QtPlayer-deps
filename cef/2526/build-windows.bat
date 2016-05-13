set GYP_DEFINES=proprietary_codecs=1 ffmpeg_branding=Chrome target_arch=x64
set GYP_GENERATORS=ninja,msvs-ninja
set GYP_MSVS_VERSION=2013
set CEF_BRANCH=2526

if not exist D:\cefbuild mkdir D:\cefbuild
if not exist D:\cefbuild\automate-git.py copy automate-git.py D:\cefbuild\
if exist D:\cefbuild\overrides rmdir /s /q D:\cefbuild\overrides
cmd /C xcopy /E /I /Y patches-windows D:\cefbuild\overrides

cd D:\cefbuild
cmd /C python automate-git.py --download-dir=cef_%CEF_BRANCH% --no-build --branch=%CEF_BRANCH%

cmd /C xcopy /E /I /Y overrides\* cef_%CEF_BRANCH%\chromium\src\patch\

cd cef_%CEF_BRANCH%
cd chromium\src
cd cef

cmd /C cef_create_projects.bat
cd ..

cmd /C python build/util/lastchange.py > build/util/LASTCHANGE
cmd /C python build/util/lastchange.py > build/util/LASTCHANGE.blink

ninja -C out\Release_x64 cefclient

cd cef\tools
make_distrib.bat --ninja-build --x64-build --allow-partial


