#!/bin/sh

. ./include/help.sh
. ./include/mysql.sh
. ./include/string.sh
. ./include/go3c.sh
. ./include/composer.sh
. ./include/laravel.sh
. ./include/download.sh

wdir=$1
ver=$2

cd $wdir || exit 1
[ -d ./laravel-5-boilerplate-master ] || download_git $wdir rappasoft/laravel-5-boilerplate master 
[ -d ./laravel-5-boilerplate-master ] || exit 1

cd laravel-5-boilerplate-master

laravel_pre
laravel_env `pwd` "boilerplate"
laravel_config_db `pwd`
laravel_config_mail `pwd`




