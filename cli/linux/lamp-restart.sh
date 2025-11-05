#!/bin/bash
set -x #echo on

sudo systemctl restart mysql
sudo systemctl restart apache2

