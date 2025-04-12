curl -sSL "https://apt.armbian.com/armbian.key" | sudo dd of=/etc/apt/keyrings/armbian.key
echo "deb [signed-by=/etc/apt/keyrings/armbian.key] https://apt.armbian.com bookworm main bookworm-utils bookworm-desktop" | sudo tee /etc/apt/sources.list.d/armbian.list
sudo apt update
sudo apt install -y linux-image-current-meson64 linux-headers-current-meson64
git clone --branch=rtl8189fs https://github.com/jwrdegoede/rtl8189ES_linux.git
cd rtl8189ES_linux
KVER="$(ls /lib/modules | head -n 1)"
KSRC="$(find /usr/src/ -maxdepth 1 -type d -name 'linux-headers-*')"
make -j $(nproc) ARCH=arm64 KSRC="$KSRC" KBUILD_CFLAGS_MODULE+="-Wno-error=date-time"
tar --numeric-owner -cf - 8189fs.ko | gzip -n > rtl8189fs-"$KVER".tar.gz
sudo chmod go+w /tmp/workspace
cp -v rtl8189fs-"$KVER".tar.gz /tmp/workspace/
sudo chmod go-w /tmp/workspace
