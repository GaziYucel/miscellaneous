exit

#!/bin/bash
set -x #echo on

sudo fwupdmgr refresh --force
sudo fwupdmgr get-updates
sudo fwupdmgr update
