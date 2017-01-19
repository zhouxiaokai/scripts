#!/bin/sh

spatie_laravel_paginateroute(){
   print_color "https://github.com/spatie/laravel-paginateroute"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
	composer require spatie/laravel-paginateroute || exit 1
   }	   
   [ -d ./vendor ] && {
     config_app_insert       $wdir  "Spatie\\\PaginateRoute\\\PaginateRouteServiceProvider::class"
     config_app_alias_insert $wdir  "PaginateRoute"  "Spatie\\\PaginateRoute\\\PaginateRouteFacade::class"
   	php artisan vendor:publish --provider="Spatie\PaginateRoute\PaginateRouteServiceProvider"
   }
}

echo "Laravel Route:"
echo "	spatie_laravel_paginateroute: easily use Laravel's paginator without the query string"
