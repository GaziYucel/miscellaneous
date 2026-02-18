exit

# disable spotlight indexing
sudo mdutil -a -i off

# remove these files recursively
find . -name ".DS_Store" -type f -delete
find /Users/me -name ".DS_Store" -type f -delete
find /opt/homebrew/var -name ".DS_Store" -type f -delete

# partition disk with 2 partitions
diskutil partitionDisk /dev/disk5 2 GPT FAT32 ssdA 3.333% FAT32 ssdB 96.667%

# format disk partition
sudo newfs_exfat -R -v ssdB -b 4096 /dev/disk5s3
sudo newfs_exfat -N /dev/disk5s3

# get disk info
diskutil info /dev/disk5s3

# unmount disk
diskutil umount /dev/disk5s3

# update / upgrade / virus update
brew update && brew upgrade && brew cleanup && freshclam

# disable .DS_Store files
# network stores
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

# removable media
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
