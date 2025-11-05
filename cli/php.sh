sudo update-alternatives --config php

sudo lsof -i tcp:9000

sudo lsof -i -n -P|grep php-fpm

brew unlink php && brew link --overwrite --force php@8.4
brew unlink php && brew link --overwrite --force php@8.3
brew unlink php && brew link --overwrite --force php@8.2
