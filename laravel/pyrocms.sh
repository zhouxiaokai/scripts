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

print_color "https://github.com/pyrocms/pyrocms"

tdir=$1
ver=$2
[ -z "$ver" ] && ver="master"
pkg="pyrocms"

wdir=$tdir/$pkg-$ver

pushd  $tdir || exit 1
pushd $wdir  || composer create-project pyrocms/pyrocms $pkg-$ver 
#download_git $tdir pyrocms/$pkg  $ver

pushd $wdir || exit 1

[ -f ./artisan ] && php artisan install

chmod -R 755 ./storage
chmod -R 755 ./bootstrap


popd
popd
