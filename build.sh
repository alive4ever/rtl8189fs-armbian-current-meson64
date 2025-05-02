set -e
cd ~
if ! echo "$PATH" | grep sbin ; then
PATH=$PATH:/usr/sbin:/sbin
fi
export DEBIAN_FRONTEND="noninteractive"
curl -sSL "https://apt.armbian.com/armbian.key" | sudo dd of=/etc/apt/keyrings/armbian.key
echo "deb [signed-by=/etc/apt/keyrings/armbian.key] https://apt.armbian.com bookworm main bookworm-utils bookworm-desktop" | sudo tee /etc/apt/sources.list.d/armbian.list
sudo apt update
sudo apt install -y linux-image-current-meson64 linux-headers-current-meson64
MODVER="0.0.1"
git clone --branch=rtl8189fs https://github.com/jwrdegoede/rtl8189ES_linux.git rtl8189fs-"$MODVER"
cp -v /tmp/workspace/dkms.conf rtl8189fs-"$MODVER"/
KVER="$(ls /lib/modules | head -n 1)"
KSRC="$(find /usr/src/ -maxdepth 1 -type d -name 'linux-headers-*')"
dkms build -m rtl8189fs/"$MODVER" -k "$KVER" --dkmstree "$PWD" --sourcetree "$PWD" --kernelsourcedir "$KSRC" -a arm64
dkms mktarball -m rtl8189fs/"$MODVER" -k "$KVER" --dkmstree "$PWD" --sourcetree "$PWD" --kernelsourcedir "$KSRC" -a arm64
OUTFILE="$(find rtl8189fs/$MODVER -name '*.tar.gz')"
echo "dkms tarball is $OUTFILE"
sudo chmod go+w /tmp/workspace
cp -v "$OUTFILE" /tmp/workspace/
sudo chmod go-w /tmp/workspace
