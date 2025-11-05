#!/bin/sh
set -x #echo on

find /Users/me/Desktop -name ".DS_Store" -type f -delete

find /opt/homebrew/var -name ".DS_Store" -type f -delete
