#!/bin/sh

tucker_eric_eloquentfilter(){

   print_color "https://github.com/Tucker-Eric/EloquentFilter"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor/ ] && {
        composer require tucker-eric/eloquentfilter
   }
   config_app_insert $wdir      "EloquentFilter\\\ServiceProvider::class"
   [ -d ./vendor ] && {
      php artisan vendor:publish --provider="EloquentFilter\ServiceProvider"
   }
}

heroicpixels_filterable(){

   print_color "https://github.com/heroicpixels/filterable"
   local wdir=$1
   pushd $wdir || exit 1
   require_insert $wdir  "heroicpixels/filterable" "dev-master"
   [ -d ./vendor/ ] && {
        composer update
   }
   config_app_insert $wdir      "Heroicpixels\\\Filterable\\\FilterableServiceProvider::class"
   [ -d ./vendor ] && {
      php artisan vendor:publish
   }
}

echo "Laravel filter package:"
echo "	tucker_eric_eloquentfilter"
echo "	heroicpixels_filterable:Automatically filter Laravel Eloquent results from URL querystring"
