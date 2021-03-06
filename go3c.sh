#!/bin/sh
. ./linux/bash.sh
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
. ./include/laravel/image.sh
. ./include/laravel/view.sh
. ./include/laravel/auth.sh
. ./include/laravel/relation.sh
. ./include/laravel/mongodb.sh
. ./include/laravel/filter.sh
. ./include/laravel/model.sh
. ./include/laravel/artisan.sh
. ./include/laravel/config.sh
. ./include/laravel/debug.sh
. ./include/laravel/query.sh
. ./include/laravel/route.sh
echo $@
$@
