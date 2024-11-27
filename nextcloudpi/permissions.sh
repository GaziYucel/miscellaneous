#!/bin/bash
set -x #echo on

path="/var/www/nextcloud_data"
chown -R www-data:www-data $path
find $path -type d -exec chmod 750 {} \;
find $path -type f -exec chmod 640 {} \;

