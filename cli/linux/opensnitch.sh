#!/bin/bash
set -x #echo on

echo '******************************'
echo opensnitch and opensnitch ui
echo '******************************'

# ubuntu 22.04
sudo apt install python3-pip -y
# not sudo!
pip3 install --ignore-installed grpcio==1.44.0

url = https://github.com/evilsocket/opensnitch
version = v1.6.6
versionSub = 1.6.6-1

wget $url/releases/download/$version/opensnitch_$versionSub_amd64.deb
wget $url/releases/download/$version/python3-opensnitch-ui_$versionSub_all.deb

sudo apt install ./opensnitch_$versionSub_amd64.deb -y
sudo apt install ./python3-opensnitch-ui_$versionSub_all.deb -y

