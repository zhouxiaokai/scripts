#!/bin/sh


laravel_config_db(){
 local wdir=$1  
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
'migrations' => 'migrations',

    'redis' => [

        'cluster' => false,

        'default' => [
            'host' => env('REDIS_HOST', 'localhost'),
            'password' => env('REDIS_PASSWORD', null),
            'port' => env('REDIS_PORT', 6379),
            'database' => 0,
        ],

    ],
];"  > $wdir/config/database.php

}

laravel_config_mail(){
 local wdir=$1
echo "
<?php

return [
 'driver' => env('MAIL_DRIVER', 'smtp'),
 'host' => env('MAIL_HOST', 'smtp.exmail.qq.com'),
 'port' => env('MAIL_PORT', 465),
 'from' => ['address' => 'laravel@go3c.org', 'name' => 'go3c'],
 'encryption' => env('MAIL_ENCRYPTION', 'ssl'),
 'username' => env('MAIL_USERNAME'),
 'password' => env('MAIL_PASSWORD'),
 'sendmail' => '/usr/sbin/sendmail -bs',
];" > $wdir/config/mail.php

}

laravel_env_app(){
echo '
APP_ENV=local
APP_DEBUG=true
APP_KEY=base64:e2W+7yWBA+CN+Ay5OXrzIKmFZgqxIvaGyQPucch1i8A=
APP_URL=http://localhost
' > $1
}


laravel_env_db(){

echo '
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=root
DB_PASSWORD=go3c86985773
' >> $1

}

laravel_env_queue(){

echo '
CACHE_DRIVER=file
SESSION_DRIVER=file
QUEUE_DRIVER=sync
' >> $1

}


laravel_env_redis(){

echo '

REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

' >>   $1

}



laravel_env_mail(){
echo '
MAIL_DRIVER=smtp
MAIL_HOST=smtp.exmail.qq.com
MAIL_PORT=465
MAIL_USERNAME=laravel@go3c.org
MAIL_PASSWORD=laraVel123$%^
MAIL_ENCRYPTION=ssl

' >> $1
}

enable_builder(){
   local wdir=$1
   sed -i '/"require":.*{/a       "infyomlabs/generator-builder": "dev-master",' $wdir/composer.json
   composer update
   sed -i '/.*InfyOmGeneratorServiceProvider::class.*$/a  \\\InfyOm\\GeneratorBuilder\\GeneratorBuilderServiceProvider::class,' $wdir/config/app.php
   php artisan vendor:publish 
   php artisan infyom.publish:generator-builder 
   php artisan route:list
}

laravel_pre(){
  composer install
  npm i
}

# fixed bug http://www.laravel.io/forum/06-09-2015-no-supported-encrypter-found-the-cipher-and-or-key-length-are-invalid
laravel_env_key(){
  local wdir=$1
  
  local key=`grep "^APP_KEY=" $wdir/.env | awk -F "=" '{print $2 }'`
  [ -z "$key" ] && {
         php artisan key:generate
  }

}

laravel_migrate(){
  php artisan migrate
}
