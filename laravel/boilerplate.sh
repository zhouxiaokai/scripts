#!/bin/sh

. ./include/help.sh
. ./include/mysql.sh
. ./include/db/mysql.sh
. ./include/string.sh
. ./include/go3c.sh
. ./include/composer.sh
. ./include/laravel.sh
. ./include/download.sh
. ./include/laravel_config.sh
wdir=$1
ver=$2

cd $wdir || exit 1
[ -d ./laravel-5-boilerplate-master ] || download_git $wdir rappasoft/laravel-5-boilerplate master 
[ -d ./laravel-5-boilerplate-master ] || exit 1

cd laravel-5-boilerplate-master

laravel_pre
laravel_env `pwd` "boilerplate"
#laravel_disable_notify  `pwd`
laravel_config_db `pwd`
laravel_config_mail `pwd`

laravel_settings `pwd`
laravel_ide_helper `pwd`

laravel_socialite_github `pwd`
laravel_session_timeout `pwd`  "true" "60"
laravel_notify_disable `pwd`
laravel_captcha `pwd`
