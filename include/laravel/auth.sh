#!/bin/sh

laravel_entrust(){
   print_color "https://github.com/Zizaco/entrust"
   local wdir=$1
   pushd $wdir || exit 1
   require_insert          $wdir  "zizaco/entrust"               "5.2.x-dev"
   config_app_insert       $wdir  "Zizaco\\\Entrust\\\EntrustServiceProvider::class"
   config_app_alias_append $wdir  "Entrust" "Zizaco\\\Entrust\\\EntrustFacade::class"
   routemw_insert          $wdir  "role"       "\\\Zizaco\\\Entrust\\\Middleware\\\EntrustRole::class"
   routemw_insert          $wdir  "permission" "\\\Zizaco\\\Entrust\\\Middleware\\\EntrustPermission::class"
   routemw_insert          $wdir  "ability"    "\\\Zizaco\\\Entrust\\\Middleware\\\EntrustAbility::class"
   [ -d ./vendor ] && {
          composer update
          php artisan vendor:publish
   }
}

echo "Auth command:"
echo "	laravel_entrust:Entrust is a succinct and flexible way to add Role-based Permissions to Laravel 5"
