#!/bin/sh

#https://laravel.com/docs/5.0/migrations
#http://labs.infyom.com/laravelgenerator/docs/5.2/boilerplates

. ./include/help.sh
. ./include/mysql.sh
. ./include/string.sh
. ./include/go3c.sh
. ./include/laravel.sh

param_check $# 1 "[work path begin with /]"
[ $? -ne 0 ]  && exit 1
tdir=$1
setdir(){
 local sdir=$1
[ -d $tdir/$sdir ] || sudo  mkdir -p $tdir/$sdir && cd $tdir/$sdir
echo "We are  $tdir/$sdir"
}


laravel_env()
{
 local fenv=$1/.env

  localhost_enable
  laravel_env_app $fenv
  laravel_env_db $fenv
  laravel_env_queue $fenv
  laravel_env_redis $fenv
  laravel_env_mail $fenv
  laravel_env_key  $1
  cd  $1 
  php artisan migrate
}


GIT="git clone --depth=1"

setdir InfyOm

[ -d $tdir/InfyOm ] || $GIT -b 5.2 https://github.com/InfyOmLabs/adminlte-generator $tdir/InfyOm/adminlte-generator

cd adminlte-generator
laravel_pre
laravel_env `pwd`
laravel_config_db `pwd`
laravel_config_mail `pwd`

wdir=`pwd`

go3c_laravel $wdir "https://cdn.datatables.net/1.10.12/" "s|https://cdn.datatables.net/1.10.12|http://www.go3c.tv/assets/ajax/libs/datatables/1.10.12|g"
go3c_laravel $wdir "//cdn.datatables.net/1.10.12/" "s|//cdn.datatables.net/1.10.12|http://www.go3c.tv/assets/ajax/libs/datatables/1.10.12|g"
go3c_laravel $wdir "https://ajax.googleapis.com" "s|https://ajax.googleapis.com|http://www.go3c.tv/assets|g"

go3c_laravel $wdir "https://cdn.datatables.net/buttons/" "s|https://cdn.datatables.net/buttons/|http://www.go3c.tv/assets/ajax/libs/datatables/buttons/|g"
go3c_laravel $wdir "https://cdnjs.cloudflare.com" "s|https://cdnjs.cloudflare.com|http://www.go3c.tv/assets|g"
go3c_laravel $wdir "http://maxcdn.bootstrapcdn.com" "s|http://maxcdn.bootstrapcdn.com|http://www.go3c.tv/assets/ajax/libs|g"
go3c_laravel $wdir "https://code.ionicframework.com" "s|https://code.ionicframework.com|http://www.go3c.tv/assets/ajax/libs|g"

php artisan serve --host=0

