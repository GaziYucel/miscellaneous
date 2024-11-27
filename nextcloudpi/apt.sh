#!/bin/bash
set -x #echo on

sudo apt update
sudo apt upgrade -y
sudo apt autoremove --purge
sudo apt autoclean
sudo apt clean

