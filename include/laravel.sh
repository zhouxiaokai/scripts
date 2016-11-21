#!/bin/sh


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


laravel_env_db(){

local dbn=$1
[ -z "$dbn" ] && dbn="model"
echo '
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE="'$dbn'"
DB_USERNAME=root
DB_PASSWORD=go3c86985773
' >> $1

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

enable_builder(){
   local wdir=$1
   cd $wdir
   print_color "enable_builder"
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


#https://github.com/Brotzka/laravel-dotenv-editor/wiki/Installation
laravel_dotenv_editor(){
  print_color "https://github.com/Brotzka/laravel-dotenv-editor/wiki/Installation"
   
  local wdir=$1
  cd $wdir 
  composer require brotzka/laravel-dotenv-editor
  sed -i 's|.*"brotzka/laravel-dotenv-editor": "^2.0"|"brotzka/laravel-dotenv-editor": "2.*"|g' ./composer.json
  composer update
  
  grep "DotenvEditorServiceProvider::class" ./config/app.php || sed -i '/.*App\\Providers\\AppServiceProvider::class,.*$/i \  Brotzka\\DotenvEditor\\DotenvEditorServiceProvider::class,' ./config/app.php
  grep "DotenvEditorFacade::class" ./config/app.php || sed -i "/.*\\App::class,.*$/i \         'DotenvEditor' => Brotzka\\DotenvEditor\\DotenvEditorFacade::class," ./config/app.php
  sed -i '/^.*App\\Http\\Controllers\\EnvController@test.*$/d'  ./vendor/brotzka/laravel-dotenv-editor/src/Http/routes.php
  php artisan vendor:publish
}

# see for detail https://github.com/VentureCraft/revisionable#display
laravel_revisionable(){

  local wdir=$1
  cd $wdir
  print_color "https://github.com/VentureCraft/revisionable#display"
  grep  "venturecraft/revisionable" ./composer.json || sed -i '/"require":.*{/a       "venturecraft/revisionable": "1.*",' $wdir/composer.json
  composer update
  php artisan migrate --path=vendor/venturecraft/revisionable/src/migrations
}

laravel_datatables(){
  print_color  "https://github.com/yajra/laravel-datatables"
 local wdir=$1
  cd $wdir
  composer require   yajra/laravel-datatables-oracle:~6.0
  composer update

  grep ".*DatatablesServiceProvider::class" ./config/app.php || sed -i '/.*App\\Providers\\AppServiceProvider::class,.*$/i \  Yajra\\Datatables\\DatatablesServiceProvider::class,' ./config/app.php
  php artisan vendor:publish --tag=datatables

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


laravel_datatable_builder(){
 local wdir=$1
 print_color "https://github.com/Distilleries/DatatableBuilder"
 require_insert $wdir    "distilleries\/datatable-builder" "2.8.*"
 require_insert $wdir    "distilleries\/form-builder" "2.8.*"
 config_app_insert $wdir "Distilleries\\\FormBuilder\\\FormBuilderServiceProvider::class"
 config_app_insert $wdir "Distilleries\\\DatatableBuilder\\\DatatableBuilderServiceProvider::class"

 config_app_alias_insert $wdir "FormBuilder" "Distilleries\\\FormBuilder\\\Facades\\\FormBuilder::class"
 config_app_alias_insert $wdir "Datatable" "Distilleries\\\DatatableBuilder\\\Facades\\\DatatableBuilder::class"
 package_dep_insert $wdir  "datatables"  "1.10.*"
  cd $wdir &&  composer update
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

laravel_debugbar(){
  print_color "https://github.com/barryvdh/laravel-debugbar"
  local wdir=$1
  cd $wdir || exit 1
  [ -d ./vendor ] && composer require barryvdh\/laravel-debugbar
  [ -d ./vendor ] || require_insert $wdir    "barryvdh\/laravel-debugbar" "2.3.*"
  config_app_append       $wdir "Barryvdh\\\Debugbar\\\ServiceProvider::class"
  config_app_alias_append $wdir "Debugbar"  "Barryvdh\\\Debugbar\\\Facade::class" 
  [ -f ./artisan ] && php artisan vendor:publish --provider="Barryvdh\Debugbar\ServiceProvider"
  
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
  cd $wdir || exit 1
  [ -d ./vendor ] && {
    composer require anahkiasen/former 
  }
  config_app_append       $wdir "Former\\\FormerServiceProvider::class"
  config_app_alias_append $wdir "Former" "Former\\\Facades\\\Former::class"
  [ -f ./artisan ] && php artisan vendor:publish --provider="Former\FormerServiceProvider"
}
