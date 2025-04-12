apt update
apt upgrade -y
useradd -m -G sudo -s /bin/bash builder
passwd -d builder
