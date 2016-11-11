#!/bin/sh

#https://laravel.com/docs/5.0/migrations
#http://labs.infyom.com/laravelgenerator/docs/5.2/boilerplates

. ./include/help.sh
. ./include/mysql.sh
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

$GIT -b 5.2 https://github.com/InfyOmLabs/adminlte-generator 

cd adminlte-generator
laravel_pre
laravel_env `pwd`

