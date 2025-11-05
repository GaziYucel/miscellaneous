#!/bin/bash
set -x #echo on

# apt.sh
sudo apt update
sudo apt upgrade -y
sudo apt autoremove --purge
sudo apt autoclean
sudo apt clean

# nc.sh
sudo -u www-data php /var/www/nextcloud/occ files:cleanup
sudo -u www-data php /var/www/nextcloud/occ sharing:cleanup-remote-storages
sudo -u www-data php /var/www/nextcloud/occ versions:cleanup
sudo -u www-data php /var/www/nextcloud/occ bookmarks:clear-previews
sudo -u www-data php /var/www/nextcloud/occ trashbin:cleanup --all-users
sudo -u www-data php /var/www/nextcloud/occ preview:pre-generate
sudo rm /var/www/nextcloud_data/nextcloud.log

# db.sh
sudo mysqlcheck -u root --auto-repair --optimize --all-databases

# maintenance.sh
sudo fstrim -v -a
