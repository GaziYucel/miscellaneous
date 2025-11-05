#!/bin/bash
set -x #echo on

echo '******************************'
echo firewall 
echo '******************************'

sudo ufw reset

sudo ufw enable

sudo ufw default deny incoming

sudo ufw default allow outgoing

sudo ufw reload

sudo ufw status

