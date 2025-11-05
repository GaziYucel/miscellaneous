exit

#!/bin/bash
set -x #echo on

# Unmount volume
diskutil umount /Volumes/owc

# Mount a volume prompting only for its password:
veracrypt -t -k "" --pim=0 --protect-hidden=no /dev/disk4s3 /Volumes/ssd
