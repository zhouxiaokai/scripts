#!/bin/sh

unlu_laravel_api_query_builder(){
   print_color "https://github.com/selahattinunlu/laravel-api-query-builder"
   local wdir=$1
   pushd $wdir || exit 1
   require_insert          $wdir  "unlu/laravel-api-query-builder" "~1.0"
   [ -d ./vendor ] && {
          composer update || exit 1
   	  config_app_insert       $wdir  "Unlu\\\Laravel\\\Api\\\ApiQueryBuilderServiceProvider::class"
	  php artisan vendor:publish --provider="Unlu\Laravel\Api\ApiQueryBuilderServiceProvider"
   }
}

echo "Laravel Query:"
echo "	unlu_laravel_api_query_builder:This package creates eloquent query from uri parameters"
