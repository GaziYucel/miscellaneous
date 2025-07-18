exit

#!/bin/bash
set -x #echo on

sudo apt update
sudo apt upgrade -y
sudo apt autoremove --purge
sudo apt autoclean
sudo apt clean

# sudo apt update && sudo apt upgrade -y && sudo apt autoremove --purge && sudo apt autoclean && sudo apt clean

# apt update && apt upgrade -y && apt autoremove --purge && apt autoclean && apt clean

