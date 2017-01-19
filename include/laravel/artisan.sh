#!/bin/sh

laravel_nice_artisan(){
   print_color "https://github.com/bestmomo/nice-artisan"
   local wdir=$1
   pushd $wdir || exit 1
   [ -f $wdir/composer.json ]  && {
   	composer require bestmomo/nice-artisan || exit 1
   }
   config_app_insert       $wdir  "Bestmomo\\\NiceArtisan\\\NiceArtisanServiceProvider::class"
   [ -d ./vendor ] && {
          composer update
          php artisan vendor:publish  --tag=niceartisan:config
   }
}

laravel_terminal(){
   print_color "https://github.com/recca0120/laravel-terminal"
   local wdir=$1
   pushd $wdir || exit 1
   require_insert $wdir "recca0120/terminal"   "^1.6.3"
   [ -f $wdir/composer.json ]  && {
        composer update  || exit 1
   }
   config_app_insert       $wdir  "Recca0120\\\Terminal\\\TerminalServiceProvider::class"
   [ -d ./vendor ] && {
          composer update
          php artisan vendor:publish  --tag="Recca0120\Terminal\TerminalServiceProvider"
   }
}


echo "Laravel Artisan package:"
echo "	artisan_anywhere: execue artisan anywhere"
echo "	artisan_tab_anywhere: execue artisan anywhere with tab"
echo "	laravel_nice_artisan:This package is to add a web interface for Laravel 5 Artisan."
echo "	laravel_terminal: Runs artisan command in web application"
