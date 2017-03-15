#!/bin/bash

#build essential
sudo apt-get install -y build-essential perl python git 
sudo apt-get install -y libfontconfig1-dev libfreetype6-dev libx11-dev libxext-dev libxfixes-dev libxi-dev \
						libxrender-dev libxcb1-dev libx11-xcb-dev libxcb-glx0-dev
sudo apt-get install -y "^libxcb.*" libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev
sudo apt-get install -y libgstreamer1.0-dev libgstreamer-vaapi1.0-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev \
						libgstreamer-plugins-good1.0-dev libgstreamer-plugins-bad1.0-dev 
sudo apt-get install -y libgl1-mesa-dev libegl1-mesa-dev mesa-common-dev

sudo apt-get install -y libcap-dev libbz2-dev libgcrypt11-dev libpci-dev build-essential libxcursor-dev libxcomposite-dev \
						libxdamage-dev libxrandr-dev libdrm-dev libfontconfig1-dev libxtst-dev libasound2-dev gperf \
                        libcups2-dev libpulse-dev libudev-dev libssl-dev flex bison ruby libxss-dev libatkmm-1.6-dev
sudo apt-get install -y flex bison gperf libxslt-dev ruby
sudo apt-get install -y libssl-dev libxcursor-dev libxcomposite-dev libxdamage-dev libxrandr-dev libfontconfig1-dev
sudo apt-get install -y libasound2-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev
sudo apt-get install -y libdbus-1-dev

sudo add-apt-repository -y ppa:wsnipex/vaapi
sudo apt-get update
sudo apt-get install -y libva-dev

#webengine:
sudo apt-get install -y libcap-dev libxrandr-dev libxcomposite-dev libxcursor-dev libxtst-dev libudev-dev libpci-dev libfontconfig1-dev libxss-dev

#gstreamer:
sudo apt-get install -y gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly gstreamer1.0-plugins-bad gstreamer1.0-libav libgstreamer1.0-0 libgstreamer-plugins-bad1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-good1.0-dev

