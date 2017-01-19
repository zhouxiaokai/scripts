#!/bin/sh

laravel_debugbar(){
  print_color "https://github.com/barryvdh/laravel-debugbar"
  local wdir=$1
  pushd $wdir || exit 1
  [ -d ./vendor ] && {
	composer require barryvdh\/laravel-debugbar || exit 1
   }
  config_app_append       $wdir "Barryvdh\\\Debugbar\\\ServiceProvider::class"
  config_app_alias_append $wdir "Debugbar"  "Barryvdh\\\Debugbar\\\Facade::class"
  [ -f ./vendor ] && {
      php artisan vendor:publish --provider="Barryvdh\Debugbar\ServiceProvider"
  }
}



lsrur_inspector(){
   print_color "https://github.com/lsrur/inspector"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
   	composer require lsrur/inspector
   }
   config_app_insert        $wdir  "Lsrur\\\Inspector\\\InspectorServiceProvider::class"
   config_app_alias_append $wdir   "Inspector"  "Lsrur\\\Inspector\\\Facade\\\Inspector::class"
   [ -d ./vendor ] && php artisan vendor:publish
}

itsgoingd_clockwork(){

   print_color "https://github.com/itsgoingd/clockwork"
   local wdir=$1
   pushd $wdir || exit 1
   [ -f ./composer.json ] && require_insert $wdir  "itsgoingd/clockwork"  "~1.12"
   [ -d ./vendor ] && {
        composer update || exit 1
	composer require ptrofimov/clockwork-cli:*
   }
    config_app_insert        $wdir  "Clockwork\\\Support\\\Laravel\\\ClockworkServiceProvider::class"
    config_app_alias_append  $wdir  "Clockwork" "Clockwork\\\Support\\\Laravel\\\Facade::class"	
    mw_insert  $wdir "Clockwork\\\Support\\\Laravel\\\ClockworkMiddleware::class"
  [ -d ./vendor ] && {
		php artisan vendor:publish --provider='Clockwork\Support\Laravel\ClockworkServiceProvider'
	}
}

echo "Laravel Debug pacakge:"
echo "	laravel_debugbar:"
echo "	itsgoingd_clockwork:Clockwork is a Chrome extension for PHP development"
echo "	lsrur_inspector:Laravel Inspector, debugging and profiling tools for Web Artisans"
