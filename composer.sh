#!/bin/sh
. ./include/string.sh
. ./include/help.sh
. ./include/mysql.sh
. ./include/db/mysql.sh
. ./include/composer.sh
. ./include/laravel.sh
. ./include/go3c.sh
. ./include/download.sh
. ./include/npm.sh
. ./include/composer/redis.sh
echo $@
$@
