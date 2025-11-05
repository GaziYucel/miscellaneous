exit

#!/bin/bash
set -x #echo on

sudo systemctl restart NetworkManager.service

sudo update-initramfs -u -k all

sudo update-grub

sudo fstrim -v -a

# (The first time only) install & run fwupdmgr
sudo apt update \
    && sudo apt install fwupd \
    && fwupdmgr refresh --force \
    && fwupdmgr get-updates \
    && fwupdmgr update

# (Every subsequent time thereafter) just run fwupdmgr once it's installed
fwupdmgr refresh --force \
    && fwupdmgr get-updates \
    && fwupdmgr update

