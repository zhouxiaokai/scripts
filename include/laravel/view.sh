#!/bin/sh

laravel_markdown(){
   print_color "https://github.com/GrahamCampbell/Laravel-Markdown"
   local wdir=$1
   pushd $wdir || exit 1

   [ -d ./vendor ] && {
       composer require graham-campbell/markdown || exit 1
   } 

   config_app_insert       $wdir "GrahamCampbell\\\Markdown\\\MarkdownServiceProvider::class"
   config_app_alias_append $wdir "Markdown" "GrahamCampbell\\\Markdown\\\Facades\\\Markdown::class"
   [ -d ./vendor ] && {
        php artisan vendor:publish
   }

}

laravel_exception(){
   print_color "https://github.com/GrahamCampbell/Laravel-Exceptions"
   local wdir=$1
   pushd $wdir || exit 1

   [ -d ./vendor ] && {
      composer require graham-campbell/exceptions
   }
   config_app_insert $wdir "GrahamCampbell\\\Exceptions\\\ExceptionsServiceProvider::class"
   print_color "You then MUST change your App\Exceptions\Handler class to extend GrahamCampbell\Exceptions\NewExceptionHandler for Laravel 5.3 "
   [ -d ./vendor ] && {
        php artisan vendor:publish
   }
}

laravel_auto_presenter(){
   print_color "https://github.com/laravel-auto-presenter/laravel-auto-presenter"
   local wdir=$1
   pushd $wdir || exit 1

   [ -d ./vendor ] && {
       composer require mccool/laravel-auto-presenter || exit 1
   }

   config_app_insert       $wdir "McCool\\\LaravelAutoPresenter\\\AutoPresenterServiceProvider::class"
   [ -d ./vendor ] && {
        php artisan vendor:publish
   }

}

echo "View Pkg:"
echo "		laravel_markdown:  CommonMark wrapper"
echo "		laravel_exception:  utilises the Whoops package for the development error pages. "
echo "		laravel_auto_presenter: automatically decorates objects bound to views during the view render process"
