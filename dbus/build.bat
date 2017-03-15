@echo off
SET PATH=C:\cygwin64\bin;%PATH%
CALL "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64
if exist run.sh del run.sh

echo ^

set -e ^

rm -rf archive archive-dbg build dbus* expat* *.zip ^

wget http://downloads.sourceforge.net/project/expat/expat/2.1.1/expat-2.1.1.tar.bz2 ^

git clone git://anongit.freedesktop.org/dbus/dbus ^

tar -jxf expat-2.1.1.tar.bz2 ^

mkdir build ^

cd build ^

mkdir expat ^

cd expat ^

cmake ../../expat-2.1.1 -G "Visual Studio 14 Win64" ^

msbuild.exe expat.sln /p:Configuration=Release ^

cd .. ^

mkdir expatd ^

cd expatd ^

cmake -DCMAKE_BUILD_TYPE=Debug ../../expat-2.1.1 -G "Visual Studio 14 Win64" ^

msbuild.exe expat.sln /p:Configuration=Debug ^

cd .. ^

mkdir dbus ^

cd dbus ^

cmake -DEXPAT_INCLUDE_DIR="../../expat-2.1.1/lib" -DEXPAT_LIBRARY="../expat/Release/expat.lib" ../../dbus/cmake -G "Visual Studio 14 Win64" ^

msbuild.exe dbus.sln /p:Configuration=Release ^

cd .. ^

mkdir dbusd ^

cd dbusd ^

cmake -DCMAKE_BUILD_TYPE=Debug -DEXPAT_INCLUDE_DIR="../../expat-2.1.1/lib" -DEXPAT_LIBRARY="../expatd/Debug/expat.lib" ../../dbus/cmake -G "Visual Studio 14 Win64" ^

msbuild.exe dbus.sln /p:Configuration=Debug ^

cd .. ^

cd .. ^

mkdir archive ^

cd archive ^

cp ../build/dbus/bin/Release/dbus* ./ ^

cp ../build/expat/Release/expat.dll ./ ^

zip -y ../../dbus.zip * ^

cd .. ^

mkdir archive-dbg ^

cd archive-dbg ^

cp ../build/dbusd/bin/Debug/dbus* ./ ^

cp ../build/expatd/Debug/expat.dll ./ ^

zip -y ../../dbus-dbg.zip * ^

echo Done > run.sh

bash -e run.sh

