#!/bin/sh

laravel_ardent(){
        print_color "https://github.com/laravel-ardent/ardent"
           local wdir=$1
   pushd $wdir || exit 1
   require_insert_dev $wdir  "laravelbook/ardent"  "3.*"
   [ -d ./vendor ] && {
        composer update || exit 1
   }
   [ -d ./vendor ] && {
        php artisan vendor:publish
   }

}

adamwathan_eloquent_oauth_l5(){
   print_color "https://github.com/adamwathan/eloquent-oauth-l5"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
   	composer require adamwathan/eloquent-oauth-l5 || exit 1
   }
    config_app_insert       $wdir "AdamWathan\\\EloquentOAuthL5\\\EloquentOAuthServiceProvider::class"
    config_app_alias_insert $wdir "SocialAuth" "AdamWathan\\\EloquentOAuth\\\Facades\\\OAuth::class"
   [ -d ./vendor ] && {
     php artisan eloquent-oauth:install
     php artisan migrate
	}
}

echo "Laravel Model"
echo "	laravel_ardent:Self-validating, secure and smart models for Laravel's Eloquent ORM"
echo "	adamwathan_eloquent_oauth_l5:Eloquent OAuth service provider and assets for Laravel 5"
