#!/bin/sh

#https://laravel.com/docs/5.0/migrations
#http://labs.infyom.com/laravelgenerator/docs/5.2/boilerplates

. ./include/help.sh
. ./include/mysql.sh
. ./include/db/mysql.sh
. ./include/string.sh
. ./include/go3c.sh
. ./include/laravel_config.sh
. ./include/composer.sh
. ./include/laravel.sh
. ./include/download.sh

param_check $# 1 "[work path begin with /]"
[ $? -ne 0 ]  && exit 1
tdir=$1
ver=$2
dbn=$3
localhost_enable

wdir=$tdir/adminlte-generator-$ver


pushd $tdir || exit 1    
pushd $tdir/adminlte-generator-$ver || {
 download_git $tdir/ InfyOmLabs/adminlte-generator $ver
 echo "pwd=`pwd`"
 pushd $tdir/adminlte-generator-$ver || exit 1
 laravel_pre
laravel_env         $wdir
laravel_config_db   $wdir  $dbn
laravel_config_mail $wdir

laravel_socialite_github $wdir
laravel_session_timeout $wdir  "true" "60"
laravel_notify_disable $wdir
laravel_captcha $wdir
php artisan vendor:publish  
}    

echo "Config for InfyOm builder"
laravel_infyom_builder $wdir

echo "Enable DebugBar"
laravel_debugbar $wdir

./go3c.sh laravel_replace $wdir/adminlte-generator-$ver

php artisan serve --host=0

