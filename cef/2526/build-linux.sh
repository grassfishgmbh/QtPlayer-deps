CEF_BRANCH=2526

sudo umount chroot/home/ubuntu/buildspace || true

if [ ! -d buildspace ]; then
	mkdir buildspace
   	sudo chown 1000:1000 buildspace
fi

if [ -d buildspace/overrides ]; then
    sudo rm -rf buildspace/overrides
    sudo mkdir buildspace
    sudo chown 1000:1000 buildspace
fi

sudo umount chroot/run/shm || true
sudo rm -rf chroot
mkdir chroot
sudo debootstrap --variant=minbase --components=main,restricted,universe,multiverse --include=ca-certificates,ssl-cert,wget,python,python2.7,git,sudo,curl,file,cmake,lsb-release,libgtkglext1-dev --arch=amd64 trusty ./chroot http://de.archive.ubuntu.com/ubuntu/
sudo chroot chroot adduser --disabled-password --gecos "" ubuntu
sudo chroot --userspec 1000:1000 chroot mkdir /home/ubuntu/buildspace
sudo mount --bind buildspace chroot/home/ubuntu/buildspace

sudo cp -r patches-linux buildspace/overrides

sudo chroot chroot <<EOF
echo "ubuntu      ALL = NOPASSWD: ALL" >> /etc/sudoers
echo "" >> /etc/fstab
echo "none /dev/shm tmpfs rw,nosuid,nodev,noexec 0 0" >> /etc/fstab
EOF

sudo chroot --userspec 1000:1000 chroot <<\EOF
# print environment variables
set
sudo mount /dev/shm
CEF_BRANCH=2526

cd /home/ubuntu

# Run the script excluding unnecessary components.
# yes | sudo ./install-build-deps.sh --no-arm --no-chromeos-fonts --no-nacl --no-prompt

cd buildspace
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git

export PATH=/home/ubuntu/buildspace/depot_tools:$PATH

rm -f automate-git.py
wget https://bitbucket.org/chromiumembedded/cef/raw/master/tools/automate/automate-git.py
python2.7 automate-git.py --download-dir=/home/ubuntu/buildspace/cef_$CEF_BRANCH --depot-tools-dir=/home/ubuntu/buildspace/depot_tools --no-build --branch=$CEF_BRANCH 

echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections

cp -r overrides/* cef_$CEF_BRANCH/chromium/src/cef/patch/

cd cef_$CEF_BRANCH
cd chromium/src

# Now install all the necessary build dependencies
yes | sudo build/install-build-deps.sh --no-arm --no-chromeos-fonts --no-nacl --no-prompt
sudo apt-get -y install libtool libvdpau-dev libvdpau1 libva1 libva-dev

export GYP_DEFINES="proprietary_codecs=1 ffmpeg_branding=Chrome clang=0 use_allocator=none"
export GYP_GENERATORS="ninja"

cd cef
./cef_create_projects.sh
cd ..

build/util/lastchange.py > build/util/LASTCHANGE
build/util/lastchange.py > build/util/LASTCHANGE.blink
rm -rf cef/binary_distrib/* || true

ninja -C out/Release cefclient chrome_sandbox
NINJAEXIT=$?
if [ "$NINJAEXIT" != "0" ]; then
    echo "Failed build with exit code $NINJAEXIT"
    exit 1
fi

cd cef/tools
./make_distrib.sh --allow-partial --ninja-build

EOF
