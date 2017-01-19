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
tdir=$1
ver=$2
[ -z "$ver" ] && ver="master"
pushd $tdir || exit 1
pkg="laravel-authentication-acl"
wdir=$tdir/$pkg-$ver
#pushd $wdir || composer create-project laravel/laravel $pkg
#pushd $wdir || exit 1
echo "hello $ver"
[ -d $wdir ] || download_git $tdir intrip/$pkg $ver
echo "hello2"
pushd $wdir || exit 1


laravel_pre
laravel_env `pwd` "l5acl"
#laravel_disable_notify  `pwd`
laravel_config_db `pwd`
laravel_config_mail `pwd`


