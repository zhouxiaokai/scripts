#!/bin/sh


laravel_new(){
  local tdir=$1
  local prj=$2
  local dbn=$3
  [ -z $dbn ] && dbn=laravel_$prj
  echo "new $prj under dir $tdir"
  cd $tdir || exit 1
  export PATH=$PATH:~/.composer/vendor/bin
  LARAVEL="~/.composer/vendor/bin/laravel"
  [ -d ./$prj ] || ~/.composer/vendor/bin/laravel new $prj || exit 1
   cd $prj || exit 1 
   composer config  repo.packagist composer https://packagist.phpcomposer.com
   sudo   chown -R www:www $tdir/$prj/bootstrap/cache
   sudo   chmod -R 755 $tdir/$prj/bootstrap/cache

   sudo   chown -R www:www $tdir/$prj/storage
   sudo   chmod -R 755 $tdir/$prj/storage

   
  laravel_pre
  laravel_env `pwd` $dbn
  #laravel_disable_notify  `pwd`
  laravel_config_db `pwd`
  laravel_config_mail `pwd`
  laravel_socialite_github `pwd`
  laravel_session_timeout `pwd`  "true" "60"
  laravel_notify_disable `pwd`
  laravel_captcha `pwd`

}


laravel_config_db(){
 local wdir=$1  
echo "
<?php

return [
'fetch' => PDO::FETCH_CLASS,
'default' => env('DB_CONNECTION', 'mysql'),

'connections' => [

        'sqlite' => [
            'driver'   => 'sqlite',
            'database' => storage_path() . '/database.sqlite',
            'prefix'   => '',
        ],

        'mysql' => [
            'driver'    => 'mysql',
            'host'      => env('DB_HOST', 'localhost'),
            'database'  => env('DB_DATABASE', 'laravel'),
            'username'  => env('DB_USERNAME', 'root'),
            'password'  => env('DB_PASSWORD', 'go3c86985773'),
            'charset'   => 'utf8',
            'collation' => 'utf8_unicode_ci',
            'prefix'    => '',
            'strict'    => false,
            'port'      => env('DB_PORT', 3306),
        ]
    ],
'migrations' => 'migrations',

    'redis' => [

        'cluster' => false,

        'default' => [
            'host' => env('REDIS_HOST', 'localhost'),
            'password' => env('REDIS_PASSWORD', null),
            'port' => env('REDIS_PORT', 6379),
            'database' => 0,
        ],

    ],
];"  > $wdir/config/database.php

}

laravel_config_mail(){
 local wdir=$1
echo "
<?php

return [
 'driver' => env('MAIL_DRIVER', 'smtp'),
 'host' => env('MAIL_HOST', 'smtp.exmail.qq.com'),
 'port' => env('MAIL_PORT', 465),
 'from' => ['address' => 'laravel@go3c.org', 'name' => 'go3c'],
 'encryption' => env('MAIL_ENCRYPTION', 'ssl'),
 'username' => env('MAIL_USERNAME'),
 'password' => env('MAIL_PASSWORD'),
 'sendmail' => '/usr/sbin/sendmail -bs',
];" > $wdir/config/mail.php

}

laravel_env_app(){
echo '
APP_ENV=local
APP_DEBUG=true
APP_KEY=base64:e2W+7yWBA+CN+Ay5OXrzIKmFZgqxIvaGyQPucch1i8A=
APP_URL=http://localhost
' > $1
}

laravel_disable_notify(){

echo  "DISABLE_NOTIFIER=true" >> $1/.env 

}


laravel_env_db(){

local dbn=$2
[ -z "$dbn" ] && dbn="model"
echo "
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=$dbn
DB_USERNAME=root
DB_PASSWORD=go3c86985773
" >> $1
new_db $dbn root go3c86985773
}

laravel_env_queue(){

echo '
CACHE_DRIVER=file
SESSION_DRIVER=file
QUEUE_DRIVER=sync
' >> $1

}


laravel_env_redis(){

echo '

REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

' >>   $1

}



laravel_env_mail(){
echo '
MAIL_DRIVER=smtp
MAIL_HOST=smtp.exmail.qq.com
MAIL_PORT=465
MAIL_USERNAME=laravel@go3c.org
MAIL_PASSWORD=laraVel123$%^
MAIL_ENCRYPTION=ssl

' >> $1
}


laravel_pre(){
  composer install
  npm i
}

# fixed bug http://www.laravel.io/forum/06-09-2015-no-supported-encrypter-found-the-cipher-and-or-key-length-are-invalid
laravel_env_key(){
  local wdir=$1
  
  local key=`grep "^APP_KEY=" $wdir/.env | awk -F "=" '{print $2 }'`
  [ -z "$key" ] && {
         php artisan key:generate
  }

}

laravel_migrate(){
  php artisan migrate
}



laravel_env()
{
 local fenv=$1/.env
 local dbn=$2
  localhost_enable
  laravel_env_app $fenv
  laravel_env_db $fenv $dbn
  laravel_env_queue $fenv
  laravel_env_redis $fenv
  laravel_env_mail $fenv
  laravel_env_key  $1
  cd  $1
  php artisan migrate
}

laravel_replace(){

local wdir=$1
replace_all $wdir "https://cdn.datatables.net/1.10.12/" "s|https://cdn.datatables.net/1.10.12|http://www.go3c.tv/assets/ajax/libs/datatables/1.10.12|g"
replace_all $wdir "//cdn.datatables.net/1.10.12/" "s|//cdn.datatables.net/1.10.12|http://www.go3c.tv/assets/ajax/libs/datatables/1.10.12|g"
replace_all $wdir "https://ajax.googleapis.com" "s|https://ajax.googleapis.com|http://www.go3c.tv/assets|g"
replace_all $wdir "//ajax.googleapis.com" "s|//ajax.googleapis.com|//www.go3c.tv/assets|g"

replace_all $wdir "https://cdn.datatables.net/buttons/" "s|https://cdn.datatables.net/buttons/|http://www.go3c.tv/assets/ajax/libs/datatables/buttons/|g"
replace_all $wdir "https://cdnjs.cloudflare.com" "s|https://cdnjs.cloudflare.com|http://www.go3c.tv/assets|g"
replace_all $wdir "http://maxcdn.bootstrapcdn.com" "s|http://maxcdn.bootstrapcdn.com|http://www.go3c.tv/assets/ajax/libs|g"
replace_all $wdir "https://maxcdn.bootstrapcdn.com" "s|https://maxcdn.bootstrapcdn.com|http://www.go3c.tv/assets/ajax/libs|g"
replace_all $wdir "//maxcdn.bootstrapcdn.com" "s|//maxcdn.bootstrapcdn.com|http://www.go3c.tv/assets/ajax/libs|g"
replace_all $wdir "https://code.ionicframework.com" "s|https://code.ionicframework.com|http://www.go3c.tv/assets/ajax/libs|g"
replace_all $wdir "http://infyom.com" "s|http://infyom.com|http://www.go3c.tv|g"


replace_all $wdir "https://netdna.bootstrapcdn.com" "s|https://netdna.bootstrapcdn.com|http://www.go3c.tv/assets/ajax/libs|g"
replace_all $wdir "http://netdna.bootstrapcdn.com" "s|http://netdna.bootstrapcdn.com|http://www.go3c.tv/assets/ajax/libs|g"
replace_all $wdir "//netdna.bootstrapcdn.com" "s|//netdna.bootstrapcdn.com|http://www.go3c.tv/assets/ajax/libs|g"


replace_all $wdir "https://cdnjs.cloudflare.com" "s|https://cdnjs.cloudflare.com|http://www.go3c.tv/assets/|g"
replace_all $wdir "http://cdnjs.cloudflare.com" "s|http://cdnjs.cloudflare.com|http://www.go3c.tv/assets/|g"
replace_all $wdir "//cdnjs.cloudflare.com" "s|//cdnjs.cloudflare.com|http://www.go3c.tv/assets/|g"

}

laravel_config(){
  local wdir=$1
  pushd $wdir || exit 1
  laravel_pre
  laravel_env         $wdir
  laravel_config_db   $wdir  $dbn
  laravel_config_mail $wdir

  laravel_socialite_github $wdir
  laravel_session_timeout $wdir  "true" "60"
  laravel_notify_disable $wdir
  laravel_captcha $wdir
  php artisan vendor:publish
  laravel_replace $wdir
  popd
}

laravel_infyom_builder(){
   local wdir=$1
   cd $wdir
   print_color "https://github.com/InfyOmLabs/laravel-generator"
   grep  "infyomlabs/generator-builder" ./composer.json || sed -i '/"require":.*{/a       "infyomlabs/generator-builder": "dev-master",' $wdir/composer.json
   composer update
   grep "GeneratorBuilderServiceProvider::class" ./config/app.php ||  sed -i '/.*InfyOmGeneratorServiceProvider::class.*$/a  \\\InfyOm\\GeneratorBuilder\\GeneratorBuilderServiceProvider::class,' $wdir/config/app.php
   php artisan vendor:publish
   php artisan infyom.publish:generator-builder
   php artisan route:list
}

laravel_Swaggervel(){
   print_color "https://github.com/slampenny/Swaggervel"
   local wdir=$1 
   cd $wdir 
    grep  "jlapp/swaggervel" ./composer.json || sed -i '/"require":.*{/a       "jlapp/swaggervel": "dev-master",' $wdir/composer.json
    grep ".*SwaggervelServiceProvider::class" ./config/app.php || sed -i '/.*App\\Providers\\RouteServiceProvider::class,.*$/i \  Jlapp\\Swaggervel\\SwaggervelServiceProvider::class,' ./config/app.php
   php artisan vendor:publish || exit 1
   return 0
}



# see for detail https://github.com/VentureCraft/revisionable#display
laravel_revisionable(){

  local wdir=$1
  cd $wdir
  print_color "https://github.com/VentureCraft/revisionable#display"
  grep  "venturecraft/revisionable" ./composer.json || sed -i '/"require":.*{/a       "venturecraft/revisionable": "1.*",' $wdir/composer.json
  [ -d ./vendor ] && {
   composer update
    php artisan migrate --path=vendor/venturecraft/revisionable/src/migrations
  }
}

laravel_datatables(){
  print_color  "https://github.com/yajra/laravel-datatables"
 local wdir=$1
  cd $wdir
  composer require yajra/laravel-datatables-oracle:^6.0
#  composer require   yajra/laravel-datatables-buttons:dev-master
  composer update
  config_app_insert $wdir "Yajra\\\Datatables\\\DatatablesServiceProvider::class"
#  config_app_insert $wdir "Yajra\\\Datatables\\\ButtonsServiceProvider::class"
  [ -d ./vendor ] &&{ 
     php artisan vendor:publish --tag=datatables
  #   php artisan vendor:publish --tag=datatables-buttons
  }
}

laravel_template(){
  print_color "http://labs.infyom.com/laravelgenerator/docs/5.3/adminlte-templates"
  local wdir=$1
  cd $wdir
      sed -i 's|^.*infyomlabs/core-templates.*$|         "infyomlabs/adminlte-templates": "5.3.x-dev",|g' ./composer.json
      sed -i 's|^.*\\InfyOm\\CoreTemplates\\CoreTemplatesServiceProvider::class.*$|InfyOm\\AdminLTETemplates\\AdminLTETemplatesServiceProvider::class, |g' ./config/app.php
      sed -i 's|core-templates|adminlte-templates|g' ./config/infyom/laravel_generator.php

      sed -i 's|^.*infyomlabs/metronic-templates.*$|         "infyomlabs/adminlte-templates": "5.3.x-dev",|g' ./composer.json
      sed -i 's|^.*InfyOm\\MetronicTemplates\\MetronicTemplatesServiceProvider::class.*$|InfyOm\\AdminLTETemplates\\AdminLTETemplatesServiceProvider::class, |g' ./config/app.php
      sed -i 's|metronic-templates|adminlte-templates|g' ./config/infyom/laravel_generator.php
      composer update
      php artisan infyom.publish:layout
      return 0
}

laravel_form_builder(){
 print_color "https://github.com/kristijanhusak/laravel-form-builder"
  local wdir=$1
  cd $wdir || exit 1
  sed -i 's/.*\"kris\/laravel-form-builder\":.*\"1\.6.*\".*$/           "kris\/laravel-form-builder\": \"1\.\*\",/g'  $wdir/vendor/distilleries/form-builder/composer.json
  sed -i 's/.*\"kris\/laravel-form-builder\":.*\"1\.6.*\".*$/           "kris\/laravel-form-builder\": \"1\.\*\",/g'  $wdir/vendor/composer/installed.json
  [ -d ./vendor ] && composer require kris/laravel-form-builder
  [ -d ./vendor ] || require_insert $wdir  "kris\/laravel-form-builder" "1.*"
  config_app_insert       $wdir "Kris\\\LaravelFormBuilder\\\FormBuilderServiceProvider::class"
  config_app_alias_append $wdir "FormBuilder"    "Kris\\\LaravelFormBuilder\\\Facades\\\FormBuilder::class"
  [ -f ./artisan ] && php artisan vendor:publish --provider="Kris\LaravelFormBuilder\FormBuilderServiceProvider"
}


laravel_datatable_builder(){
 local wdir=$1
 print_color "https://github.com/Distilleries/DatatableBuilder"
 laravel_form_builder $wdir
 require_insert $wdir    "distilleries\/datatable-builder" "2.8.*"
 require_insert $wdir    "distilleries\/form-builder" "2.8.*"
 config_app_insert $wdir "Distilleries\\\FormBuilder\\\FormBuilderServiceProvider::class"
 config_app_insert $wdir "Distilleries\\\DatatableBuilder\\\DatatableBuilderServiceProvider::class"

 config_app_alias_insert $wdir "FormBuilder" "Distilleries\\\FormBuilder\\\Facades\\\FormBuilder::class"
 config_app_alias_insert $wdir "Datatable" "Distilleries\\\DatatableBuilder\\\Facades\\\DatatableBuilder::class"
 package_dep_insert $wdir  "datatables"  "1.10.*"
  cd $wdir 
  [ -d ./vendor ] &&{
          composer update || exit 1
          php artisan vendor:publish --provider="Distilleries\FormBuilder\FormBuilderServiceProvider"
          php artisan vendor:publish --provider="Distilleries\FormBuilder\FormBuilderServiceProvider"  --tag="views"
  }
}


laravel_debugbar(){
  print_color "https://github.com/barryvdh/laravel-debugbar"
  local wdir=$1
  cd $wdir || exit 1
  [ -d ./vendor ] && composer require barryvdh\/laravel-debugbar
  [ -d ./vendor ] || require_insert $wdir    "barryvdh\/laravel-debugbar" "2.3.*"
  config_app_append       $wdir "Barryvdh\\\Debugbar\\\ServiceProvider::class"
  config_app_alias_append $wdir "Debugbar"  "Barryvdh\\\Debugbar\\\Facade::class" 
  [ -f ./vendor ] && {
      php artisan vendor:publish --provider="Barryvdh\Debugbar\ServiceProvider"
  }
}

laravel_twig(){
  print_color "https://github.com/rcrowe/TwigBridge"
  local wdir=$1
  cd $wdir || exit 1
  [ -d ./vendor ] && composer require  rcrowe/twigbridge
  
  [ -d ./vendor ] || require_insert $wdir    "rcrowe\/twigbridge" "0.9.*"
  config_app_append       $wdir "TwigBridge\\\ServiceProvider::class"
  config_app_alias_append $wdir "Twig"  "TwigBridge\\\Facade\\\Twig::class"
  [ -f ./artisan ] && php artisan vendor:publish --provider="TwigBridge\ServiceProvider"
}

laravel_cashier(){
   print_color "https://laravel.com/docs/5.3/billing"
    local wdir=$1
    cd $wdir || exit 1
  require_insert $wdir    "laravel/cashier" "7.*"
  require_insert $wdir "laravel/cashier-braintree" "2.*"
  config_app_append       $wdir "Laravel\\\Cashier\\\CashierServiceProvider::class"
  [ -d ./vendor ] && composer update
  [ -f ./artisan ] && php artisan vendor:publish --provider="Laravel\Cashier\CashierServiceProvider"

}

laravel_passport(){
  print_color "https://laravel.com/docs/5.3/passport"
  local wdir=$1
  cd $wdir || exit 1
  config_app_append       $wdir "Laravel\\\Passport\\\PassportServiceProvider::class"
  [ -d ./vendor ] && {
           composer require laravel/passport  
           composer update
           php artisan migrate
           php artisan passport:install
           php artisan vendor:publish --tag=passport-components
   }
  [ -f ./artisan ] && php artisan vendor:publish --provider="Laravel\Cashier\CashierServiceProvider"

}

laravel_scout(){
 print_color "https://laravel.com/docs/5.3/scout"
  local wdir=$1
  cd $wdir || exit 1
  config_app_append       $wdir "Laravel\\\Scout\\\ScoutServiceProvider::class"
  [ -d ./vendor ] && {
           composer require laravel/scout
           composer require algolia/algoliasearch-client-php
   }
  [ -f ./artisan ] && php artisan vendor:publish --provider="Laravel\Scout\ScoutServiceProvider"


}

laravel_socialite(){
  print_color "https://github.com/laravel/socialite"
  local wdir=$1
  cd $wdir || exit 1
  [ -d ./vendor ] && {
        composer require  laravel/socialite
  }
  config_app_append       $wdir " Laravel\\\Socialite\\\SocialiteServiceProvider::class"
  config_app_alias_append $wdir "Socialite" "Laravel\\\Socialite\\\Fayycades\\\Socialite::class"
  [ -f ./artisan ] && php artisan vendor:publish --provider="Laravel\Socialite\SocialiteServiceProvider"


}

laravel_administrator(){
  print_color "https://github.com/FrozenNode/Laravel-Administrator"
  local wdir=$1
  cd $wdir || exit 1
  config_app_append       $wdir "Frozennode\\\Administrator\\\AdministratorServiceProvider::class"
  [ -d ./vendor ] && {
     composer require "frozennode/administrator: 5.*"
   }
  [ -f ./artisan ] && php artisan vendor:publish --provider="Frozennode\Administrator\AdministratorServiceProvider"
}

laravel_former(){
  print_color "https://github.com/formers/former"
    local wdir=$1
  pushd $wdir || exit 1
  [ -d ./vendor ] && {
    composer require anahkiasen/former 
  }
  config_app_append       $wdir "Former\\\FormerServiceProvider::class"
  config_app_alias_append $wdir "Former" "Former\\\Facades\\\Former::class"
  [ -f ./artisan ] && php artisan vendor:publish --provider="Former\FormerServiceProvider"
  popd
}

laravel_settings(){
  print_color "https://github.com/anlutro/laravel-settings"
  local wdir=$1
  pushd $wdir || exit 1
  [ -d ./vendor ] && {
   composer require anlutro/l4-settings
   config_app_insert $wdir "anlutro\\\LaravelSettings\\\ServiceProvider::class"
   config_app_alias_insert $wdir "Setting" "anlutro\\\LaravelSettings\Facade::class"
  }
  [ -f ./artisan ] &&  {
       php artisan vendor:publish
       php artisan migrate
 }
  popd
}

laravel_ide_helper(){
  print_color "https://github.com/barryvdh/laravel-ide-helper"
  local wdir=$1
  pushd $wdir || exit 1
  [ -d ./vendor ] && {
   composer require barryvdh/laravel-ide-helper
   composer require doctrine/dbal
   config_app_insert $wdir "Barryvdh\\\LaravelIdeHelper\\\IdeHelperServiceProvider::class"
  }
  [ -f ./artisan ] &&  {
   php artisan clear-compiled
   php artisan ide-helper:generate
   php artisan vendor:publish 
  }
  popd
}

laravel_ardent(){
  print_color "https://github.com/laravel-ardent/ardent"
  local wdir=$1
  cd $wdir || exit 1
  [ -d ./vendor ] && {
   composer require  laravelbook/ardent
  }
}

laravel_logview(){
  print_color "https://github.com/ARCANEDEV/LogViewer/blob/master/_docs/2.Installation-and-Setup.md"
  local wdir=$1
  cd $wdir || exit 1
  require_insert $wdir    "arcanedev/log-viewer" "~4.0"
  [ -d ./vendor ] && {
   composer update
  }
  config_app_append $wdir "Arcanedev\\\LogViewer\\\LogViewerServiceProvider::class"
  [ -f ./artisan ] &&  {
   php artisan log-viewer:publish
   php artisan log-viewer:publish --force
   php artisan log-viewer:publish --tag=config
   php artisan log-viewer:publish --tag=lang
   php artisan log-viewer:check
  }
}

laravel_cart(){
   print_color "https://github.com/Crinsane/LaravelShoppingcart"
  local wdir=$1
  cd $wdir || exit 1
  [ -d ./vendor ] && {
   composer require gloudemans/shoppingcart
  }
  config_app_insert       $wdir "Gloudemans\\\Shoppingcart\\\ShoppingcartServiceProvider::class"
  config_app_alias_insert $wdir "Cart" "Gloudemans\\\Shoppingcart\\\Facades\\\Cart::class"
  [ -f ./artisan ] &&  {
   php artisan log-viewer:publish
  }
}

laravel_gen_ex(){
  print_color "https://github.com/laracasts/Laravel-5-Generators-Extended"
  local wdir=$1
  pushd $wdir || exit 1
  [ -d ./vendor ] && {
     composer require laracasts/generators --dev
   }

  config_app_dev_insert  $wdir "\$this->app->register('Laracasts\\\Generators\\\GeneratorsServiceProvider')"

  print_color " php artisan make:migration:schema create_users_table --schema=\"username:string, email:string:unique\" "
  print_color " shcema: --schema=\"username:string, email:string:unique\""
  print_color " --model=false  model off"
  print_color " php artisan make:migration:schema remove_user_id_from_posts_table --schema=\"user_id:integer\""
  print_color " php artisan make:migration:schema create_posts_table"
  print_color " php artisan make:migration:schema create_posts_table --schema=\"title:string, body:text, excerpt:string:nullable\""
  print_color " php artisan make:migration:schema remove_excerpt_from_posts_table --schema=\"excerpt:string:nullable\""
  print_color " php artisan make:migration:schema create_posts_table --schema=\"user_id:integer:foreign, title:string, body:text\" "
  print_color " php artisan make:migration:pivot tags posts "
  popd
}

laravel_repository(){
  print_color "https://github.com/andersao/l5-repository"
  local wdir=$1
  pushd $wdir || exit 1
  [ -d ./vendor ] && {
     composer require prettus/l5-repository
   }

  config_app_append  $wdir "Prettus\\\Repository\\\Providers\\\RepositoryServiceProvider::class"
  php artisan vendor:publish
}

laravel_menu(){
  print_color "https://github.com/lavary/laravel-menu"
  local wdir=$1
  pushd $wdir || exit 1
  [ -d ./vendor ] && {
  composer require lavary/laravel-menu 
}

  config_app_insert  $wdir "Lavary\\\Menu\\\ServiceProvider::class"
  config_app_alias_append $wdir  "Menu"   "Lavary\\\Menu\\\Facade::class"
  print_color " php artisan make:migration:schema create_users_table --schema=\"username:string, email:string:unique\" "
  print_color " shcema: --schema=\"username:string, email:string:unique\""
  print_color " --model=false  model off"
  print_color " php artisan make:migration:schema remove_user_id_from_posts_table --schema=\"user_id:integer\""
  print_color " php artisan make:migration:schema create_posts_table"
  print_color " php artisan make:migration:schema create_posts_table --schema=\"title:string, body:text, excerpt:string:nullable\""
  print_color " php artisan make:migration:schema remove_excerpt_from_posts_table --schema=\"excerpt:string:nullable\""
  print_color " php artisan make:migration:schema create_posts_table --schema=\"user_id:integer:foreign, title:string, body:text\" "
  print_color " php artisan make:migration:pivot tags posts "

}

laravel_menu_spatie(){
  print_color "https://github.com/spatie/laravel-menu"
  print_color "Conflict with lavary Menu for alias"
  local wdir=$1
  pushd $wdir || exit 1
  [ -d ./vendor ] && {
      composer require spatie/laravel-menu
  }
   config_app_insert $wdir "Spatie\\\Menu\\\Laravel\\\MenuServiceProvider::class"
   config_app_alias_append $wdir "Menu" "Spatie\\\Menu\\\Laravel\\\MenuServiceProvider::class"
  print_color " Added a View item implementation to use blade views as menu items"
  print_color "Conditional Items Based on Permissions linkifcan" 
  print_color "All classes in the laravel-menu package use the Macroable trait for quick & easy extensions"
  print_color "Building a menu from a data source" 
  [ -f ./artisan ] && php artisan vendor:publish
}

laravel_stydenet_html(){
  print_color "https://github.com/StydeNet/html"
  print_color "generate common HTML components, extension of  https://github.com/laravelcollective/html"
  local wdir=$1
  pushd $wdir || exit 1
  [ -d ./vendor ] && {
      composer require "styde/html=~1.2"
  }
   config_app_insert $wdir "Styde\\\Html\\\HtmlServiceProvider::class"
   config_app_alias_append $wdir "Access" "Styde\\\Html\\\Facades\\\Access::class"
  print_color "Form Filed Builder"
  print_color "Form Builder"
  print_color "Html Builder "
  print_color "Menu Builder"
  print_color "Alert Builder"
  print_color "Theme Builder"
  print_color "Access Builder"
  [ -f ./artisan ] && {
    php artisan vendor:publish --provider='Styde\Html\HtmlServiceProvider'
  }
}

laravel_modelfromtable(){

  print_color "https://github.com/laracademy/generators"
  print_color "php artisan generate:modelfromtable --table=users,posts"
  print_color "php artisan generate:modelfromtable --table=user --folder=app\Models"
  print_color "php artisan generate:modelfromtable --connection=spark --all"
  local wdir=$1
  pushd $wdir || exit 1
  [ -d ./vendor ] && {
    composer require "laracademy/generators"
  }          
   config_app_insert $wdir "Laracademy\\\Generators\\\GeneratorsServiceProvider::class"
  [ -f ./artisan ] && {
    php artisan vendor:publish --provider='Styde\Html\HtmlServiceProvider'
  }

}

laravel_migration_gen(){
  print_color "https://github.com/Xethron/migrations-generator"
  print_color "php artisan help migrate:generate"
  local wdir=$1
  pushd $wdir || exit 1 
  [ -d ./vendor ] && {
   composer config repositories.repo-name vcs "https://github.com/jamisonvalenta/Laravel-4-Generators.git"
   composer require --dev "way/generators:dev-feature/laravel-five-stable" "xethron/migrations-generator"
  }          
   config_app_insert $wdir "Way\\\Generators\\\GeneratorsServiceProvider::class"
   config_app_insert $wdir "Xethron\\\MigrationsGenerator\\\MigrationsGeneratorServiceProvider::class"
  [ -f ./artisan ] && {
    php artisan help migrate:generate
  } 
}

laravel_formers(){
  
  print_color "https://github.com/formers/former"
  print_color "A Laravelish way to create and format forms.Could use without laravel"
  local wdir=$1
  pushd $wdir || exit 1
  [ -d ./vendor ] && {
    composer require anahkiasen/former
  }
   config_app_insert $wdir "Former\\\FormerServiceProvider::class"
   config_app_alias_append $wdir "Former"  "Former\\\Facades\\\Former::class"

}

laravel_sms(){

  print_color "https://github.com/toplan/laravel-sms"
  print_color "һ¸öÚaravelµÄֻú֤½â·½°¸"
  local wdir=$1
  pushd $wdir || exit 1
  [ -d ./vendor ] && {
    composer require toplan/laravel-sms:2.5.*
  }
   config_app_insert $wdir "Toplan\\\PhpSms\\\PhpSmsServiceProvider::class"
   config_app_insert $wdir "Toplan\\\Sms\\\SmsManagerServiceProvider::class"
   config_app_alias_append $wdir "PhpSms"      "Toplan\\\PhpSms\\\Facades\\\Sms::class"
   config_app_alias_append $wdir "SmsManager"  "Toplan\\\Sms\\\Facades\\\SmsManager::class"
  [ -f ./artisan ] && {
       php artisan vendor:publish
  }

}

laravel_infyom(){
   print_color "http://labs.infyom.com/laravelgenerator/docs/5.3/installation"
   local wdir=$1
    pushd $wdir || exit 1
   require_insert $wdir "laracasts/flash"               "~2.0"
   require_insert $wdir "infyomlabs/laravel-generator"  "5.3.x-dev"
   require_insert $wdir "laravelcollective/html"        "dev-master"
   require_insert $wdir "infyomlabs/adminlte-templates" "5.3.x-dev"
   require_insert $wdir "infyomlabs/swagger-generator"  "dev-master"
   require_insert $wdir "jlapp/swaggervel"              "dev-master"
   require_insert $wdir "doctrine/dbal"                 "~2.3"
  
   config_app_insert $wdir "Collective\\\Html\\\HtmlServiceProvider::class"
   config_app_insert $wdir "Laracasts\\\Flash\\\FlashServiceProvider::class"
   config_app_insert $wdir "Prettus\\\Repository\\\Providers\\\RepositoryServiceProvider::class"
   config_app_insert $wdir "\\\InfyOm\\\Generator\\\InfyOmGeneratorServiceProvider::class"
   config_app_insert $wdir "\\\InfyOm\\\AdminLTETemplates\\\AdminLTETemplatesServiceProvider::class"
   
   config_app_alias_append $wdir "Form"       "Collective\\\Html\\\FormFacade::class"
   config_app_alias_append $wdir "Html"       "Collective\\\Html\\\HtmlFacade::class"
   config_app_alias_append $wdir "Flash"      "Laracasts\\\Flash\\\Flash::class"
   [ -d ./vendor ] && {
    composer update
    php artisan vendor:publish
    php artisan infyom:publish
    php artisan infyom.publish:layout 
    grep "HomeController@index" ./routes/web.php ||  {
      echo "" >> ./routes/web.php
      echo "Route::get('/home', 'HomeController@index');" >> ./routes/web.php  
    }  
   }
}


laravel_schema_view(){
   print_color "https://github.com/NickCousins/SchemaViewLaravel"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
     composer require nickcousins/schemaview-laravel
   }
    config_app_insert       $wdir "nickcousins\\\schemaview\\\SchemaViewServiceProvider::class"
}

laravel_table_view(){
   print_color "https://github.com/larkinwhitaker/laravel-table-view"
   local wdir=$1
   pushd $wdir || exit 1
   require_insert  $wdir "witty/laravel-table-view"  "dev-master"
   [ -d ./vendor ] && {
     composer update || exit 1
   }
    config_app_insert       $wdir   "Witty\\\LaravelTableView\\\LaravelTableViewServiceProvider::class"
    config_app_alias_append $wdir   "TableView" "Witty\\\LaravelTableView\\\Facades\\\TableView::class"
}

laravel_distilleries_expendable(){
  print_color "https://github.com/Distilleries/Expendable"
   local wdir=$1
   pushd $wdir || exit 1
   require_insert  $wdir "distilleries/expendable"  "2.*"
   [ -d ./vendor ] && {
     composer update || exit 1
     
   }
     config_app_insert       $wdir   "Wpb\\\String_Blade_Compiler\\\ViewServiceProvider::class"
     config_app_insert       $wdir   "Distilleries\\\FormBuilder\\\FormBuilderServiceProvider::class"
     config_app_insert       $wdir   "Distilleries\\\PermissionUtil\\\PermissionUtilServiceProvider::class"
     config_app_insert       $wdir   "Distilleries\\\MailerSaver\\\MailerSaverServiceProvider::class"
     config_app_insert       $wdir   "Maatwebsite\\\Excel\\\ExcelServiceProvider::class"
     config_app_insert       $wdir   "Distilleries\\\Expendable\\\ExpendableServiceProvider::class"
     config_app_insert       $wdir   "Distilleries\\\Expendable\\\ExpendableRouteServiceProvider::class"
     config_app_alias_append $wdir "Mail"          "\\\Distilleries\\\MailerSaver\\\Facades\\\Mail::class"
     config_app_alias_append $wdir "FormBuilder"   "\\\Distilleries\\\FormBuilder\\\Facades\\\FormBuilder::class"
     config_app_alias_append $wdir "Form"          "\\\Illuminate\\\Html\\\FormFacade::class"
     config_app_alias_append $wdir "HTML"          "\\\Illuminate\\\Html\\\HtmlFacade::class"
     config_app_alias_append $wdir "Datatable"     "\\\Distilleries\\\DatatableBuilder\\\Facades\\\DatatableBuilder::class"
     config_app_alias_append $wdir "PermissionUtil" "\\\Distilleries\\\PermissionUtil\\\Facades\\\PermissionUtil::class"
     config_app_alias_append $wdir "Excel"          "\\\Maatwebsite\\\Excel\\\Facades\\\Excel::class"
     [ -d ./vendor ] && php artisan vendor:publish --provider="Distilleries\Expendable\ExpendableServiceProvider"
}


laravel_distilleries(){
      print_color "https://github.com/Distilleries/Expendable"
      local wdir=$1
      pushd $wdir || exit 1
      
      npm i laravel-elixir
      npm i laravel-elixir-vueify
      npm i gulp-git
      npm i gulp-filter
      npm i gulp-tag-version
      npm i gulp-bump
      popd 
}

laravel_evercode1(){
   print_color "https://github.com/evercode1/trait-maker"
   print_color "https://github.com/RobinRadic/blade-extensions"
   print_color "https://github.com/evercode1/view-maker"
   print_color "https://github.com/evercode1/trait-maker"
   print_color "https://github.com/evercode1/foundation-maker"
   local wdir=$1
   pushd $wdir || exit 1
   require_insert  $wdir "radic/blade-extensions" "~6.2"
   [ -d ./vendor ] && {
     composer update
     composer require evercode1/view-maker
     composer require evercode1/trait-maker
     composer require evercode1/foundation-maker 
     composer require sven/artisan-view 
   }
    config_app_insert       $wdir   "Evercode1\\\TraitMaker\\\TraitMakerServiceProvider::class"
    config_app_insert       $wdir   "Evercode1\\\FoundationMaker\\\FoundationMakerServiceProvider::class"
    config_app_insert       $wdir   "Evercode1\\\ViewMaker\\\ViewMakerServiceProvider::class"
    config_app_insert       $wdir   "Sven\\\ArtisanView\\\ArtisanViewServiceProvider::class"
    config_app_insert       $wdir   "Radic\\\BladeExtensions\\\BladeExtensionsServiceProvider::class"
    popd
}

laravel_viewcounter(){
   print_color "https://github.com/fraank/ViewCounter"
   local wdir=$1
   pushd $wdir || exit 1
   require_insert  $wdir "fraank/view-counter" "dev-master"
   [ -d ./vendor ] && {
     composer update 
   }
   config_app_insert       $wdir   "Fraank\\\ViewCounter\\\ViewCounterServiceProvider::class"
   popd
}


laravel_talvbansal_easel(){
   print_color "https://github.com/talvbansal/easel a blog system basing laravel"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
      composer require talvbansal/easel
   }
   config_app_insert        $wdir               "\\\Easel\\\Providers\\\EaselServiceProvider::class"
   [ -d ./vendor ] && {
      php artisan easel:install
      php artisan db:seed
   }
}
