#!/bin/sh


laravel_mongodb_eloquent(){
   print_color "https://github.com/jenssegers/laravel-mongodb"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
   	composer require jenssegers/mongodb || exit 1
        composer require jenssegers/mongodb-sentry || exit 1
        composer require jenssegers/mongodb-session || exit 1
   }
   config_app_insert $wdir "Jenssegers\\\Mongodb\\\MongodbServiceProvider::class"
   config_app_insert $wdir "Jenssegers\\\Mongodb\\\Auth\\\PasswordResetServiceProvider::class"
   config_app_insert $wdir "Jenssegers\\\Mongodb\\\MongodbQueueServiceProvider::class"
   config_app_insert $wdir "Jenssegers\\\Mongodb\\\Session\\\SessionServiceProvider::class"
   config_app_alias_append  $wdir   "Moloquent"  "Jenssegers\\\Mongodb\\\Eloquent\\\Model::class"
   [ -d ./vendor ] && php artisan vendor:publish
}

echo "Laravel Mongodb package:"
echo "	laravel_mongodb_eloquent"
