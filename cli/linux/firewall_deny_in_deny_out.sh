#!/bin/bash
set -x #echo on

echo '******************************'
echo firewall enable
echo '******************************'

sudo ufw reset

sudo ufw enable

sudo ufw default deny incoming

sudo ufw default deny outgoing

### localhost
sudo ufw allow from 127.0.0.1

# imap
sudo ufw allow out 993

# smtp
sudo ufw allow out 465

# qbitorrent
sudo ufw allow 6969

# dns
sudo ufw allow out 53

# http
sudo ufw allow out http
sudo ufw allow out https

# ssh
sudo ufw allow out 22

# rdp
sudo ufw allow out 3389
sudo ufw allow out 51972

# avahi daemon
sudo ufw allow out 5353

# printer
sudo ufw allow out 9100
sudo ufw allow out CUPS

sudo ufw reload

sudo ufw status

