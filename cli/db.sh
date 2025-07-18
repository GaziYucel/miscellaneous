exit

#!/bin/bash
set -x #echo on

sudo mysqlcheck -u root --auto-repair --optimize --all-databases

