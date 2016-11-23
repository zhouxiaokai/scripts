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

print_color "https://www.invoiceninja.com/self-host/"

wdir=$1
ver=$2
[ -z "$ver" ] && ver="master"
PKG="invoiceninja"

pushd  $wdir || exit 1
[ -d ./$PKG-master ] || download_git $wdir invoiceninja/$PKG  master 
[ -d ./$PKG-master ] || exit 1
chmod -R 755 storage

pushd $PKG-master

laravel_pre
laravel_env `pwd` "ninja"
#laravel_disable_notify  `pwd`
laravel_config_db `pwd`
laravel_config_mail `pwd`

composer dump-autoload --optimize
php artisan optimize --force
php artisan migrate
php artisan db:seed --class=UpdateSeeder

#laravel_settings `pwd`
#laravel_ide_helper `pwd`

#laravel_socialite_github `pwd`
#laravel_session_timeout `pwd`  "true" "60"
#laravel_notify_disable `pwd`
#laravel_captcha `pwd`

popd
popd
