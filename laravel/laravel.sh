#!/bin/sh

[ $# -lt 2 ] && {

echo "$0 [new] [dir]"
exit 1
}
check_env(){
  composer config -g repo.packagist composer https://packagist.phpcomposer.com
  composer global require "laravel/installer"
  [ -f ~/.bashrc ] &&  grep composer ~/.bashrc || export PATH=$PATH:~/.composer/vendor/bin
  [ -f ~/.bashrc ] ||  {
  echo '
  #!/bin/sh
  export PATH=$PATH:~/.composer/vendor/bin
' > ~/.bashrc
}
}

project_env(){
path=$1
echo 'APP_ENV=local
APP_KEY=base64:QdSD2oagofIO8+msRySAyfiAxfX5RN9vBBADzampYYA=
APP_DEBUG=true
APP_LOG_LEVEL=debug
APP_URL=http://localhost

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=root
DB_PASSWORD=go3c86985773

BROADCAST_DRIVER=log
CACHE_DRIVER=file
SESSION_DRIVER=file
QUEUE_DRIVER=sync

REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_DRIVER=smtp
MAIL_HOST=mailtrap.io
MAIL_PORT=2525
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null

PUSHER_APP_ID=
PUSHER_KEY=
PUSHER_SECRET=' > $1/.env

}

help_demo(){
  echo "$0 demo [work dir]"
  exit 1
}

laravel_config(){
  local wdir=$1
  echo "echo file to $wdir/"
  [ -d $wdir/config ] || mkdir $wdir/config
  echo "
<?php

return [     
'fetch' => PDO::FETCH_CLASS,
'default' => env('DB_CONNECTION', 'mysql'),
    
'connections' => [

        'sqlite' => [
            'driver'   => 'sqlite',
            'database' => storage_path() . '/database.sqlite',
            'prefix'   => '',
        ],

        'mysql' => [
            'driver'    => 'mysql',
            'host'      => env('DB_HOST', 'localhost'),
            'database'  => env('DB_DATABASE', 'laravel'),
            'username'  => env('DB_USERNAME', 'root'),
            'password'  => env('DB_PASSWORD', 'go3c86985773'),
            'charset'   => 'utf8',
            'collation' => 'utf8_unicode_ci',
            'prefix'    => '',
            'strict'    => false,
            'port'      => env('DB_PORT', 3306),
        ]
    ],
'migrations' => 'migrations'
];"  > $wdir/config/database.php
}

#https://github.com/yajra/laravel-datatables-demo
laravel_demo(){
   echo "laravel_demo $1"
   wdir=$1
   [ -z "$wdir" ] && help_demo
   [ -d $wdir ] || mkdir -p $wdir
   [ -d $wdir/laravel-datatables-demo ] || {
          cd $wdir &&  git clone --depth=1 https://github.com/yajra/laravel-datatables-demo 
   }
   [ -d $wdir/laravel-datatables-demo ] && {
     project_env $wdir/laravel-datatables-demo
     laravel_config  $wdir/laravel-datatables-demo
     cd $wdir/laravel-datatables-demo && composer install  && php artisan key:generate && php artisan migrate --seed && php artisan serve --host=0
    
    
} 
 
   
   #git clone --depth=1 https://github.com/yuansir/laravel5-rbac-example

 
}

project_config(){
  local dir=$1
  local prj=$2
  local pdir=$1/$2
  echo "project_config $1 $2"
  [ -f $pdir/.env ] || project_env $pdir
  sudo sed -e 's|^DB_DATABASE.*$|DB_DATABASE=laravel|g' $pdir/.env >/dev/null
  sudo sed -e 's|^DB_USERNAME.*$|DB_DATABASE=root|g' $pdir/.env  >/dev/null
  sudo sed -e 's|^DB_PASSWORD.*$|DB_DATABASE=go3c86985773|g' $pdir/.env >/dev/null
   
  laravel_config $1/$2

}

composer_new(){
   dir=$1
   [ -d $dir ] || exit 1
   composer create-project laravel/laravel $dir --prefer-dist
   project_env $dir
}

laravel_new(){
  local tdir=$1
  local prj=$2
  echo "new $prj under dir $tdir"
  cd $tdir
  export PATH=$PATH:~/.composer/vendor/bin
  LARAVEL="~/.composer/vendor/bin/laravel"
  [ -d $prj ] || ~/.composer/vendor/bin/laravel new $prj || exit 1 
  
  composer config  repo.packagist composer https://packagist.phpcomposer.com
   sudo   chown -R www:www $tdir/$prj/bootstrap/cache
   sudo   chmod -R 755 $tdir/$prj/bootstrap/cache
      
   sudo   chown -R www:www $tdir/$prj/storage
   sudo   chmod -R 755 $tdir/$prj/storage
  
   
}

case $1 in
   new) check_env || exit 1
        #create_project $2
        laravel_new $2 $3
        project_config $2 $3
          
       ;;
   cnew) composer_new $2;;
   config)project_env $2;;
   demo)laravel_demo $2
        ;;
   *) laravel_config  $2;;
esac
