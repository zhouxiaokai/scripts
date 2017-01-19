#!/bin/sh


laravel_parse(){
    print_color "https://github.com/GrahamCampbell/Laravel-Parse"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
     composer require graham-campbell/parse
   }
    config_app_insert        $wdir "GrahamCampbell\\\Parse\\\ParseServiceProvider::class"
   [ -d ./vendor ] && {
      php artisan vendor:publish
   } 
   
}


evercode1_view_maker(){
   print_color "https://github.com/evercode1/view-maker"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
       composer require evercode1/view-maker
   }
    config_app_insert        $wdir "Evercode1\\\ViewMaker\\\ViewMakerServiceProvider::class"
       echo "make:master"
   echo "       create a master page, providing dependencies, which includes"
   echo "       layouts folder, master, partial[meta,css, scripts, bottom, nav,shim, jquery, bootstrap, font-awesome]"
   echo "make:foundation:"
   echo "       create all files for crud and views, including"
   echo "               model, controller, api controller, migration, test, appropriately-names view folder, index/create,edit,show"
   echo "       appends to the following files"
   echo "               routes.php, ModelFactory.php, ApiController"
   echo "make:crud"
   echo "       create the files necessary to display a view:model,controller,api controller, migration, test"
   echo "       appends to the following files:routes.php, ModelFactory.php, ApiController"
   echo "make:views: view folder, index, create, edit, show"
   echo "make:parent-child"
   echo "       create all crud and view files for both a parent and a child, including"
   echo "       appends to the following files"
   echo "make:child-of: similar to the make:parent-child command, but only creates the child"
   echo "make:chart: create a chart of your data, including"
   echo "       chart.js chart on index"
   echo "       chart api route"
   echo "       chart api method"
   echo "       toggles line or bar type graph"
   echo "       Select period of time for graph display"
   echo "       vue.js implementation of chart.js"
}

evercode1_foundation_maker(){
   print_color "https://github.com/evercode1/foundation-maker"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
      composer require evercode1/foundation-maker
   }
   config_app_insert    $wdir "Evercode1\\\FoundationMaker\\\FoundationMakerServiceProvider::class"
   echo "	make:assets"
   echo "	make:templates"
   echo "	make:master"
   echo "	make:foundation"
   echo "	make:parent-child"
   echo "	make:child-of"
   echo "	make:exception"
   echo "	make:exception-handler"
   echo "	make:social-app"
   echo "	make:views"
   echo "	remove:"
}

evercode1_trait_maker(){
   print_color "https://github.com/evercode1/trait-maker"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
      composer require evercode1/trait-maker
   }
    config_app_insert        $wdir "Evercode1\\\TraitMaker\\\TraitMakerServiceProvider::class"
}

LeShadow_ArtisanExtended(){
   print_color "https://github.com/LeShadow/ArtisanExtended"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
     composer require sebpro/artisanext:0.2.0 || exit 1
   }
    config_app_insert        $wdir "Sebpro\\\ArtisanExt\\\ArtisanExtServiceProvider::class"
   [ -d ./vendor ] &&{
      echo "	app:serviceprovider: add to config/app.php"
      echo "	app:alias  #add alias to  config/app.php alias"
      echo "	app:url   #change URL for you app"
      echo "    app:env"  #change env
      echo "	app:ciper"
      echo "	app:locale" 
      echo "	app:cache" 
      echo "	app:queue" 
      echo "	app:session" 
      echo "	redis:host" 
      echo "	redis:port" 
      echo "	redis:password" 
      echo "	db:host" 
      echo "	db:name" 
      echo "	db:password" 
      echo "	app:user" 
      echo "	app:check" 
   
   }
}

mathiasgrimm_laravel_dot_env_gen(){
   print_color "https://github.com/mathiasgrimm/laravel-dot-env-gen"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
         composer require mathiasgrimm/laravel-dot-env-gen:dev-master || exit 1
   }
   config_app_insert        $wdir "MathiasGrimm\\\LaravelDotEnvGen\\\DotEnvGenServiceProvider::class"
   [ -d ./vendor ] && {
      php artisan vendor:publish --provider="Vendor\Providers\DotEnvGenServiceProvider" --tag="config"
      php artisan env:gen
   }
}

svenluijten_flex_env(){
   print_color "https://github.com/svenluijten/flex-env"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
     composer require sven/flex-env --dev || exit 1
   }
    config_app_insert        $wdir "Sven\\\FlexEnv\\\FlexEnvServiceProvider::class"
    [ -d ./vendor ] && php artisan env:list
}

svenluijten_env_providers(){
   print_color "https://github.com/svenluijten/env-providers"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
       composer require sven/env-providers
   }
   config_app_insert        $wdir  "Sven\\\EnvProviders\\\EnvServiceProvider::class"
   [ -d ./vendor ] && {
       php artisan vendor:publish --provider="Sven\EnvProviders\EnvServiceProvider"
   }
}


#https://github.com/Brotzka/laravel-dotenv-editor/wiki/Installation
laravel_dotenv_editor(){
  print_color "https://github.com/Brotzka/laravel-dotenv-editor/wiki/Installation"

  local wdir=$1
  pushd  $wdir || exit 1
  composer require brotzka/laravel-dotenv-editor
  sed -i 's|.*"brotzka/laravel-dotenv-editor": "^2.0"|"brotzka/laravel-dotenv-editor": "2.*"|g' ./composer.json
  composer update

  grep "DotenvEditorServiceProvider::class" ./config/app.php || sed -i '/.*App\\Providers\\AppServiceProvider::class,.*$/i \  Brotzka\\DotenvEditor\\DotenvEditorServiceProvider::class,' ./config/app.php
  grep "DotenvEditorFacade::class" ./config/app.php || sed -i "/.*\\App::class,.*$/i \         'DotenvEditor' => Brotzka\\DotenvEditor\\DotenvEditorFacade::class," ./config/app.php
  sed -i '/^.*App\\Http\\Controllers\\EnvController@test.*$/d'  ./vendor/brotzka/laravel-dotenv-editor/src/Http/routes.php
  php artisan vendor:publish
}

daftspunk_laravel_config_writer(){
   print_color "https://github.com/daftspunk/laravel-config-writer"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor/daftspunk/laravel-config-writer ] || {
         mkdir -p ./vendor/daftspunk
         cd ./vendor/daftspunk 
         git clone https://github.com/daftspunk/laravel-config-writer || { 
            popd
            exit 1
          }
        cd ../../
   }
   classmap_insert     $wdir "vendor/daftspunk/laravel-config-writer/"
   [ -d ./vendor ] && composer dump-autoload
   config_app_insert   $wdir "October\\\Rain\\\Config\\\ConfigServiceProvider::class"
}

philf_setting(){
   print_color "https://github.com/Phil-F/Setting"
   local wdir=$1
   pushd $wdir || exit 1
   require_insert $wdir "philf/setting"  "dev-master" || exit 1
   [ -d ./vendor ] && {
     composer update
   }
    config_app_insert   $wdir "Philf\\\Setting\\\SettingServiceProvider"
    
}

zachleigh_laravel_vue_generators(){
   print_color "https://github.com/zachleigh/laravel-vue-generators"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
      composer require zachleigh/laravel-vue-generators || exit 1
   }
    config_app_insert   $wdir "VueGenerators\\\ServiceProvider::class"
  [ -d ./vendor ] && {
    php artisan vendor:publish --provider="VueGenerators\ServiceProvider"
  }
}


larkinwhitaker_laravel_table_view(){
   print_color "https://github.com/larkinwhitaker/laravel-table-view"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor/witty/laravel-table-view ] || {
         mkdir -p ./vendor/witty
         cd ./vendor/witty
         git clone https://github.com/larkinwhitaker/laravel-table-view  laravel-table-view || {
            popd
            exit 1
          }
        cd ../../
   }
   classmap_insert     $wdir "vendor/witty/laravel-table-view/"
   [ -d ./vendor ] && composer dump-autoload
   config_app_insert   $wdir "Witty\\\LaravelTableView\\\LaravelTableViewServiceProvider::class"
   config_app_alias_insert $wdir "TableView" "Witty\\\LaravelTableView\\\Facades\\\TableView::class"
   [ -d ./vendor ] && {
       php artisan vendor:publish
   }
}


svenluijten_artisan_view(){
   print_color "https://github.com/svenluijten/artisan-view"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor/ ] && {
      composer require sven/artisan-view
   }
   config_app_insert   $wdir "Sven\\\ArtisanView\\\ArtisanViewServiceProvider::class"
}

nwidart_laravel_modules(){
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor/ ] && {
       composer require nwidart/laravel-modules
   }
    config_app_insert       $wdir "Nwidart\\\Modules\\\LaravelModulesServiceProvider::class"
    config_app_alias_insert $wdir "Module" "Nwidart\\\Modules\\\Facades\Module::class"
    psr4_append $wdir  "Modules\\\\\\\\" "Modules/" 
    [ -d ./vendor ] && php artisan vendor:publish --provider="Nwidart\Modules\LaravelModulesServiceProvider"
}
echo "Laravel Framewokr:"
echo "	laravel_parse: wrapper for parser server"
echo "	nwidart_laravel_modules"
echo "		php artisan module:*"
echo "mathiasgrimm_laravel_dot_env_gen"
echo "		php artisan env:gen"

echo "svenluijten_flex_env"
echo "		php artisan env:list"

echo "svenluijten_env_providers"


echo "laravel_dotenv_editor"
echo "		nothing"

echo "daftspunk_laravel_config_writer"
echo "philf_setting"

echo "View Command"
echo "	evercode1_view_maker"
echo "	evercode1_foundation_maker"
echo "	evercode1_trait_maker"
echo "	larkinwhitaker_laravel_table_view"
echo "	zachleigh_laravel_vue_generators"
