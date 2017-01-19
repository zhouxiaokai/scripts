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
. ./include/laravel_config.sh
. ./include/laravel/file.sh
. ./include/laravel/local.sh
. ./include/laravel/ide.sh
. ./include/laravel/schema.sh
. ./include/laravel/project.sh
echo $@
$@
