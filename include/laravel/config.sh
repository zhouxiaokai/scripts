#!/bin/sh

laravel_aliases(){
   print_color "https://github.com/davejamesmiller/laravel-aliases"
   local wdir=$1
   pushd $wdir || exit 1
   [ -f $wdir/composer.json ]  && {
	composer require davejamesmiller/laravel-aliases dev-master

   }
   config_app_insert       $wdir  "DaveJamesMiller\\\Aliases\\\AliasesServiceProvider::class"
   [ -d ./vendor ] && {
          composer update
          php artisan vendor:publish 
   }
}

svenluijten_env_providers(){
   print_color "https://github.com/svenluijten/env-providers"
   local wdir=$1
   pushd $wdir || exit 1
   [ -f $wdir/composer.json ]  && {
        require_insert $wdir "sven/env-providers" "^3.0"
   }
    
   [ -d ./vendor ] && {
          composer update || exit 1
   }
   config_app_insert       $wdir  "Sven\\\EnvProviders\\\EnvServiceProvider::class"
   [ -d ./vendor ] && {
          php artisan vendor:publish --provider="Sven\EnvProviders\EnvServiceProvider"
   }
}

echo "Laravel config package"
echo "	laravel_aliases:lists registered aliases and the classes they map to, including resolving facades"
echo "	svenluijten_env_providers: Load Laravel service providers based on your application's environment"
