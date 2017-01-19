#!/bin/sh



laravel_flysystem(){
   print_color "https://github.com/GrahamCampbell/Laravel-Flysystem"
   local wdir=$1
   pushd $wdir || exit 1
   require_insert  $wdir "graham-campbell/flysystem" "^3.0"
   #require_insert  $wdir "graham-campbell/manager" "^2.0"
   [ -d ./vendor ] && {
      composer update
   }
   config_app_insert        $wdir                "GrahamCampbell\\\Flysystem\\\FlysystemServiceProvider::class"
   config_app_alias_append $wdir   "Flysystem"  "GrahamCampbell\\\Flysystem\\\Facades\\\Flysystem::class"
   [ -d ./vendor ] && php artisan vendor:publish
}

jildertmiedema_laravel_plupload(){
    print_color "https://github.com/jildertmiedema/laravel-plupload"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
     composer require jildertmiedema/laravel-plupload
   }
     config_app_insert      $wdir   "JildertMiedema\\\LaravelPlupload\\\LaravelPluploadServiceProvider::class"
     config_app_alias_append  $wdir "Plupload" "JildertMiedema\\\LaravelPlupload\\\Facades\\\Plupload::class"
   [ -d ./vendor ] && php artisan vendor:publish
}


spatie_laravel_medialibrary(){
   print_color "https://github.com/spatie/laravel-medialibrary"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
     composer require spatie/laravel-medialibrary
   }
   config_app_insert        $wdir   "Spatie\\\MediaLibrary\\\MediaLibraryServiceProvider::class"   
   [ -d ./vendor ] && {
     php artisan vendor:publish --provider="Spatie\MediaLibrary\MediaLibraryServiceProvider" --tag="migrations"
     php artisan migrate
     php artisan vendor:publish --provider="Spatie\MediaLibrary\MediaLibraryServiceProvider" --tag="config"
   }
}

plank_laravel_mediable(){
   print_color "https://github.com/plank/laravel-mediable"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
     composer require plank/laravel-mediable || exit 1
   }
   config_app_insert        $wdir   "Plank\\\Mediable\\\MediableServiceProvider::class"
   config_app_alias_append  $wdir   "MediaUploader" "Plank\\\Mediable\\\MediaUploaderFacade::class"
   [ -d ./vendor ] && {
     php artisan vendor:publish --provider="Plank\Mediable\MediableServiceProvider"
     php artisan migrate
   }
   popd 
}

CodeSleeve_laravel_stapler(){
   print_color "https://github.com/CodeSleeve/laravel-stapler"
   local wdir=$1
   pushd $wdir || exit 1
   require_insert $wdir   "codesleeve/laravel-stapler" "1.0.*"
   [ -d ./vendor ] && {
     composer update  || exit 1
   }
   config_app_insert        $wdir   "Codesleeve\\\LaravelStapler\\\Providers\\\L5ServiceProvider::class"
   popd 
}

talvbansal_media_manager(){
   print_color "https://github.com/talvbansal/media-manager"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
     composer require talvbansal/media-manager  || exit 1
     composer dump-autoload
   }
   config_app_insert        $wdir   "\\\TalvBansal\\\MediaManager\\\Providers\\\MediaManagerServiceProvider::class"
   [ -d ./vendor ] && {
     php artisan vendor:publish --tag=media-manager --force
   }
   popd
}

guillermomartinez_filemanager_laravel(){
   print_color "https://github.com/guillermomartinez/filemanager-laravel"
   local wdir=$1
   pushd $wdir || exit 1

   require_insert $wdir  "pqb/filemanager-laravel"  "2.*"

   [ -d ./vendor ] && {
      composer update || exit 1
   }
   config_app_insert       $wdir "Pqb\\\FilemanagerLaravel\\\FilemanagerLaravelServiceProvider::class"
   config_app_alias_append $wdir "FilemanagerLaravel"  "Pqb\\\FilemanagerLaravel\\\Facades\\\FilemanagerLaravel::class" 
   [ -d ./vendor ] && {
     php artisan vendor:publish
   }
   popd
}

https://github.com/Maatwebsite/Laravel-Excel
maatwebsite_excel(){
   print_color "https://github.com/guillermomartinez/filemanager-laravel"
   local wdir=$1
   pushd $wdir || exit 1

   require_insert $wdir  "maatwebsite/excel"  "~2.1.0"
   [ -d ./vendor ] && {
     composer update || exit 1
   }
  config_app_insert       $wdir "Maatwebsite\\\Excel\\\ExcelServiceProvider::class"
  config_app_alias_append $wdir "Excel"  "Maatwebsite\\\Excel\\\Facades\\\Excel::class"
   [ -d ./vendor ] && {
     php artisan vendor:publish --provider="Maatwebsite\Excel\ExcelServiceProvider"
   }
   popd
}

echo "laravel_flysystem: Flysystem bridge for Laravel 5.3"
echo "guillermomartinez_filemanager_laravel"

echo  spatie_laravel_medialibrary
echo  plank_laravel_mediable
echo  "		php artisan media:import [disk]"
echo  "		php artisan media:prune [disk]"
echo  "		php artisan media:sync [disk]"

echo CodeSleeve_laravel_stapler
echo  "		php artisan stapler:fasten users avatar" 
echo  "		php artisan stapler:refresh TestPhoto --attachments=\"foo, bar, baz, etc\""

echo "file import/export"
echo "	maatwebsite_excel"
