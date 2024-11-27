#!/bin/bash
set -x #echo on

sudo -u www-data php /var/www/nextcloud/occ trashbin:cleanup --all-users
sudo -u www-data php /var/www/nextcloud/occ versions:cleanup
sudo -u www-data php /var/www/nextcloud/occ files:cleanup

sudo rm /var/www/nextcloud_data/nextcloud.log

sudo mysqlcheck -u root -p --auto-repair --optimize --all-databases

