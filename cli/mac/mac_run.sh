#!/bin/sh
set -x #echo on

# start

find /Users/me/Desktop -name ".DS_Store" -type f -delete

find /opt/homebrew/var -name ".DS_Store" -type f -delete

find /opt/homebrew/var/www -type d -exec chmod 777 {} \;

# sudo mysqlcheck -u root --auto-repair --optimize --all-databases

brew update
brew upgrade
brew cleanup

freshclam
