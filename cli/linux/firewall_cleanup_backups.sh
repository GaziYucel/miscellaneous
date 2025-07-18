#!/bin/bash
set -x #echo on

echo '******************************'
echo firewall cleanup backups
echo '******************************'

sudo rm /etc/ufw/user.rules.*
sudo rm /etc/ufw/before.rules.*
sudo rm /etc/ufw/after.rules.*
sudo rm /etc/ufw/user6.rules.*
sudo rm /etc/ufw/before6.rules.*
sudo rm /etc/ufw/after6.rules.*

