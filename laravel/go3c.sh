#!/bin/sh

#https://laravel.com/docs/5.0/migrations
#http://labs.infyom.com/laravelgenerator/docs/5.2/boilerplates

. ./include/help.sh
. ./include/mysql.sh
. ./include/string.sh
. ./include/go3c.sh
. ./include/composer.sh
. ./include/laravel.sh
. ./include/download.sh

param_check $# 1 "[work path begin with /]"
[ $? -ne 0 ]  && exit 1
tdir=$1
ver=$2

localhost_enable

wdir=$tdir/InfyOm/adminlte-generator-$ver


[ -d $wdir ] || {
	setdir $tdir/InfyOm/
	[ $? -ne 0 ] && exit 1
        echo "check $wdir"
        [ -d  $wdir ] || {
	    download_git $tdir/InfyOm/ InfyOmLabs/adminlte-generator $ver
            [ $? -ne 0 ] && exit 1
        }
        
	cd $wdir || exit 1
        echo "pwd = `pwd`"
	laravel_pre
	laravel_env `pwd`
	laravel_config_db `pwd`
	laravel_config_mail `pwd`
        php artisan vendor:publish

}

laravel_5_1(){

echo "Enable datatable Builder"
laravel_datatable_builder $1

}

laravel_5_3(){

echo "config datatables"
laravel_datatables $1

echo "config template"
laravel_template $1
}

case $ver in
  5.1*) laravel_5_1 $wdir

       ;;
  5.3*) laravel_5_1 $wdir
        laravel_5_3 $wdir
        ;;
  *);;
esac

echo "passport"
laravel_passport $wdir

echo "cashier"
laravel_cashier $wdir

echo "scout"
laravel_scout $wdir

echo "socialite"
laravel_socialite $wdir 


echo "Config laravel_form_builder"
laravel_form_builder $wdir



echo "config Swaggeravel"
laravel_Swaggervel $wdir
echo "swaggeravel =$?"

echo "Config revisionable"
laravel_revisionable $wdir

echo "Config for builder"
enable_builder $wdir
[ $? -ne 0 ] && exit 1
echo "Config for dotenv_editor"
laravel_dotenv_editor $wdir
[ $? -ne 0 ] && exit 1

echo "Enable DebugBar"
laravel_debugbar $wdir
echo "Enable Twig"
laravel_twig $wdir

go3c_laravel $wdir "https://cdn.datatables.net/1.10.12/" "s|https://cdn.datatables.net/1.10.12|http://www.go3c.tv/assets/ajax/libs/datatables/1.10.12|g"
go3c_laravel $wdir "//cdn.datatables.net/1.10.12/" "s|//cdn.datatables.net/1.10.12|http://www.go3c.tv/assets/ajax/libs/datatables/1.10.12|g"
go3c_laravel $wdir "https://ajax.googleapis.com" "s|https://ajax.googleapis.com|http://www.go3c.tv/assets|g"

go3c_laravel $wdir "https://cdn.datatables.net/buttons/" "s|https://cdn.datatables.net/buttons/|http://www.go3c.tv/assets/ajax/libs/datatables/buttons/|g"
go3c_laravel $wdir "https://cdnjs.cloudflare.com" "s|https://cdnjs.cloudflare.com|http://www.go3c.tv/assets|g"
go3c_laravel $wdir "http://maxcdn.bootstrapcdn.com" "s|http://maxcdn.bootstrapcdn.com|http://www.go3c.tv/assets/ajax/libs|g"
go3c_laravel $wdir "https://maxcdn.bootstrapcdn.com" "s|https://maxcdn.bootstrapcdn.com|http://www.go3c.tv/assets/ajax/libs|g"
go3c_laravel $wdir "https://code.ionicframework.com" "s|https://code.ionicframework.com|http://www.go3c.tv/assets/ajax/libs|g"
go3c_laravel $wdir "http://infyom.com" "s|http://infyom.com|http://www.go3c.tv|g"

php artisan serve --host=0

