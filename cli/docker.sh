exit

#!/bin/bash
set -x #echo on

docker run -itd -p 3306:3306 -e MYSQL_ROOT_PASSWORD=abc --name couter-db mariadb
docker run -itd -p 3306:3306 -e MYSQL_ROOT_PASSWORD=abc --name couter-db mysql
