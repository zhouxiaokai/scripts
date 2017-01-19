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

echo "config datatables"
laravel_datatables $wdir

echo "config template"
laravel_template $wdir

echo "passport"
laravel_passport $wdir

echo "Config for InfyOm builder"
laravel_infyom_builder $wdir
[ $? -ne 0 ] && exit 1
echo "Config for dotenv_editor"
laravel_dotenv_editor $wdir
[ $? -ne 0 ] && exit 1


laravel_gen_ex  $wdir
laravel_repository $wdir

laravel_menu $wdir


echo "Config laravel_form_builder"
laravel_form_builder $wdir

echo "config Swaggeravel"
laravel_Swaggervel $wdir
echo "swaggeravel =$?"

echo "Config revisionable"
laravel_revisionable $wdir

other(){


laravel_settings $wdir
laravel_ide_helper $wdir


echo "cashier"
laravel_cashier $wdir

echo "scout"
laravel_scout $wdir

echo "socialite"
laravel_socialite $wdir 
}

echo "Enable DebugBar"
laravel_debugbar $wdir
echo "Enable Twig"
laravel_twig $wdir

./go3c.sh laravel_replace $wdir/adminlte-generator-$ver

php artisan serve --host=0

