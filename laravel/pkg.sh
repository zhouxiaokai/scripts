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

print_color "https://github.com/msurguy/laravel-shop-menu"

tdir=$1
ver=$2
[ -z "$ver" ] && ver="master"
pkg="laravel-shop-menu"

wdir=$tdir/$pkg-$ver

pushd  $tdir || exit 1

pushd $wdir 22>/dev/null || composer create-project laravel/laravel $wdir --prefer-dist

pushd $wdir || exit 1

mv composer.json composer.json.bak

#download_git $tdir msurguy/$pkg  master 


mv composer.json composer.json.menu

cp composer.json.bak composer.json

chmod -R 755 storage


laravel_pre
laravel_env $wdir "shop-menu"
#laravel_disable_notify  $wdir
laravel_config_db $wdir  "shop-menu"
laravel_config_mail $wdir



composer install
composer dump-autoload --optimize
php artisan optimize --force
php artisan migrate


popd
popd
