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
dbn=$3
[ -z "$dbn" ] && dbn="boilerplate"

pushd $wdir || exit 1
[ -d ./laravel-5-boilerplate-master ] || {
  download_git $wdir rappasoft/laravel-5-boilerplate master
  
  pushd laravel-5-boilerplate-master || exit 1

  laravel_pre
  laravel_env `pwd` $dbn
  #laravel_disable_notify  `pwd`
  laravel_config_db `pwd`
  laravel_config_mail `pwd`
  laravel_socialite_github `pwd`
  laravel_session_timeout `pwd`  "true" "60"
  laravel_notify_disable `pwd`
  laravel_captcha `pwd`
  popd
} 

popd


#./go3c.sh laravel_gen_ex     $wdir/laravel-5-boilerplate-master

#./go3c.sh laravel_settings   $wdir/laravel-5-boilerplate-master
#./go3c.sh laravel_ide_helper $wdir/laravel-5-boilerplate-master

#./go3c.sh laravel_infyom  $wdir/laravel-5-boilerplate-master

popd 

cd laravel-5-boilerplate-master

laravel_pre
laravel_env `pwd` $dbn
#laravel_disable_notify  `pwd`
laravel_config_db `pwd`
laravel_config_mail `pwd`
laravel_socialite_github `pwd`
laravel_session_timeout `pwd`  "true" "60"
laravel_notify_disable `pwd`
laravel_captcha `pwd`

pushd /media/sdc1/jzhou/scripts || exit 1
./go3c.sh laravel_replace $wdir/laravel-5-boilerplate-master
