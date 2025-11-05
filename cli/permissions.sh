exit

#!/bin/bash
set -x #echo on

sudo chown www-data:www-data . -R
sudo find . -type d -exec chmod 775 {} \;
sudo find . -type f -exec chmod 664 {} \;

chown www-data:www-data . -R
find . -type d -exec chmod 775 {} \;
find . -type f -exec chmod 664 {} \;

find . -type d -exec chmod 777 {} \;

sudo chown -R www-data:www-data /var/www/nextcloud
sudo find /var/www/nextcloud -type d -exec chmod 750 {} \;
sudo find /var/www/nextcloud -type f -exec chmod 640 {} \;

sudo chown -R www-data:www-data /var/www/nextcloud_data
sudo find /var/www/nextcloud_data -type d -exec chmod 750 {} \;
sudo find /var/www/nextcloud_data -type f -exec chmod 640 {} \;
