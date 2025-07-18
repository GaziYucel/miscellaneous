#!/bin/bash
set -x #echo on

# apt.sh
sudo apt update
sudo apt upgrade -y
sudo apt autoremove --purge
sudo apt autoclean
sudo apt clean

# nc.sh
sudo -u www-data convmv -f utf-8 -t utf-8 -r --notest --nfc --replace /var/www/nextcloud_data
sudo -u www-data php /var/www/nextcloud/occ files:cleanup
sudo -u www-data php /var/www/nextcloud/occ files:repair-tree
sudo -u www-data php /var/www/nextcloud/occ files:scan --all
sudo -u www-data php /var/www/nextcloud/occ sharing:cleanup-remote-storages
sudo -u www-data php /var/www/nextcloud/occ versions:cleanup
sudo -u www-data php /var/www/nextcloud/occ bookmarks:clear-previews
sudo -u www-data php /var/www/nextcloud/occ maintenance:repair
sudo -u www-data php /var/www/nextcloud/occ maintenance:repair-share-owner
sudo -u www-data php /var/www/nextcloud/occ check
sudo -u www-data php /var/www/nextcloud/occ trashbin:cleanup --all-users
sudo -u www-data php /var/www/nextcloud/occ preview:pre-generate
sudo rm /var/www/nextcloud_data/nextcloud.log

# db.sh
sudo mysqlcheck -u root --auto-repair --optimize --all-databases

# permissions.sh
sudo chown -R www-data:www-data /var/www/nextcloud
sudo find /var/www/nextcloud -type d -exec chmod 750 {} \;
sudo find /var/www/nextcloud -type f -exec chmod 640 {} \;
sudo chown -R www-data:www-data /var/www/nextcloud_data
sudo find /var/www/nextcloud_data -type d -exec chmod 750 {} \;
sudo find /var/www/nextcloud_data -type f -exec chmod 640 {} \;

# os.sh
sudo fstrim -v -a
