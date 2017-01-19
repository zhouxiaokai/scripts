#!/bin/sh

laravel_schema_spy(){
	print_color "https://github.com/Stolz/laravel-schema-spy"
	local wdir=$1
	pushd $wdir || exit 1
	[ -d ./vendor ] && {
		composer require stolz/laravel-schema-spy --dev || exit 1
	}
	config_app_insert $wdir "Stolz\\\SchemaSpy\\\ServiceProvider::class"
	[ -d ./vendor ] && {
		php artisan vendor:publish
	}
}


eloquent_model_generator(){
	print_color "https://github.com/pepijnolivier/Eloquent-Model-Generator"
 	   local wdir=$1
   pushd $wdir || exit 1
   require_insert_dev $wdir "xethron/migrations-generator" "dev-l5"  
   require_insert_dev $wdir "way/generators" "dev-feature/laravel-five-stable"
   require_insert_dev $wdir "user11001/eloquent-model-generator" "~2.0"
   [ -d ./vendor ] && {
     	composer config repositories.repo-name vcs "https://github.com/jamisonvalenta/Laravel-4-Generators.git"
	composer update || exit 1
   }
	config_app_insert       $wdir "Way\\\Generators\\\GeneratorsServiceProvider::class"
	config_app_insert       $wdir "Xethron\\\MigrationsGenerator\\\MigrationsGeneratorServiceProvider::class"
	config_app_insert       $wdir "User11001\\\EloquentModelGenerator\\\EloquentModelGeneratorProvider::class"
   [ -d ./vendor ] && {
        php artisan vendor:publish
   }

}

laravel_nullable_fields(){
   print_color "https://github.com/michaeldyrynda/laravel-nullable-fields"
   local wdir=$1
   pushd $wdir || exit 1
   require_insert $wdir  "iatstuti/laravel-nullable-fields" "~1.0"
   [ -d ./vendor ] && {
     composer update
   }
    [ -d ./vendor ] && {
        php artisan vendor:publish
        php artisan migrate
   }
}

eloquent_tree(){
   
   print_color "https://github.com/AdrianSkierniewski/eloquent-tree"
   local wdir=$1
   pushd $wdir || exit 1
   require_insert $wdir  "gzero/eloquent-tree" "v3.0.*"
   [ -d ./vendor ] && {
     composer update
   }
    [ -d ./vendor ] && {
        php artisan vendor:publish
        php artisan migrate
   }
}


laravel_cascade_soft_deletes(){
   print_color "https://github.com/michaeldyrynda/laravel-cascade-soft-deletes"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
        composer require iatstuti/laravel-cascade-soft-deletes="1.1.*"
   }
}


rtconner_laravel_tagging(){
   print_color "https://github.com/rtconner/laravel-tagging"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
   	composer require rtconner/laravel-tagging "~2.2"
   }  
   config_app_insert       $wdir "\\\Conner\\\Tagging\\\Providers\\\TaggingServiceProvider::class"
   [ -d ./vendor ] && {
 	php artisan vendor:publish --provider="Conner\Tagging\Providers\TaggingServiceProvider"
	php artisan migrate
   }
}

cviebrock_eloquent_taggable(){
   print_color "https://github.com/cviebrock/eloquent-taggable"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
    	composer require cviebrock/eloquent-taggable
   }    
   config_app_insert       $wdir "\\\Cviebrock\\\EloquentTaggable\\\ServiceProvider::class"
   [ -d ./vendor ] && {
        php artisan vendor:publish --provider="Cviebrock\EloquentTaggable\ServiceProvider"
  	composer dump-autoload
	php artisan migrate 
  }
}

eloquent_sluggable(){
   print_color "https://github.com/cviebrock/eloquent-sluggable#updating-your-eloquent-models"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
   	composer require cviebrock/eloquent-sluggable:^4.1
   }
   config_app_insert       $wdir "Cviebrock\\\EloquentSluggable\\\ServiceProvider::class"
   [ -d ./vendor ] && {
      php artisan vendor:publish --provider="Cviebrock\EloquentSluggable\ServiceProvider"
   }
}



nickCousins_schemaview_laravel(){
   print_color "https://github.com/NickCousins/SchemaViewLaravel"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor/nickcousins/schemaview-laravel ] || {
         mkdir -p ./vendor/nickcousins
         cd ./vendor/nickcousins
         git clone https://github.com/NickCousins/SchemaViewLaravel schemaview-laravel || {
            popd
            exit 1
          }
        cd ../../
   }
   classmap_insert     $wdir "vendor/nickcousins/schemaview-laravel/"
   [ -d ./vendor ] && composer dump-autoload
   config_app_insert       $wdir "nickcousins\\\schemaview\\\SchemaViewServiceProvider::class"
}

nwidart_db_exporter(){
   print_color "https://github.com/nWidart/DbExporter"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
     composer require nwidart/db-exporter
   }
    config_app_insert       $wdir "Nwidart\\\DbExporter\\\DbExportHandlerServiceProvider"
   [ -d ./vendor ] && {
     php artisan config:publish nwidart/db-exporter
   }
   echo "Export command app/config/database.php"
   echo "	php artisan dbe:migrations otherDatabaseName"
   echo "	php artisan dbe:migrations --ignore=\"table1,table2\""
   echo "	php artisan dbe:seeds"
   echo "Uploading migrations/seeds to remote server app/config/remote.php"
   echo "	php artisan dbe:remote production --migrations  #upload migrations to the production server"
   echo "	php artisan dbe:remote production --seeds       #upload seeds to the production server"
   echo "	php artisan dbe:remote production --migrations --seeds  #upload both to the production server"
}


mojopollo_laravel_json_schema(){
   print_color "https://github.com/mojopollo/laravel-json-schema"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
      composer require mojopollo/laravel-json-schema --dev || exit 1
   }
    config_app_insert       $wdir "Mojopollo\\\Schema\\\MakeMigrationJsonServiceProvider::class"
    config_app_insert       $wdir "Laracasts\\\Generators\\\GeneratorsServiceProvider::class"
    echo "Command"
    echo "	php artisan make:migration:json --file=schema.json --only=categories,tags"
    echo "	php artisan make:migration:json --file=schema.json --undo"
    echo "	php artisan make:migration:json --file=schema.json --disableundo"
    echo "	php artisan make:migration:json --file=schema.json --validate"
}

echo "Laravel Model package"
echo "	eloquent_model_generator:Auto-generates all Eloquent models from the database in a Laravel 5 project."
echo "	laravel_nullable_fields:Handles saving empty fields as null for Eloquent models"
echo "	eloquent_sluggable: Easy creation of slugs for your Eloquent models in Laravel 5 "
echo "	cviebrock_eloquent_taggable:Easily add the ability to tag your Eloquent models in Laravel 5"
echo "	rtconner_laravel_tagging:   Tag support for Laravel Eloquent models - Taggable Trait"
echo "	laravel_cascade_soft_deletes: cascade soft deletes"
echo "	eloquent_tree:Eloquent Tree is a tree model for Laravel Eloquent ORM"
echo "Schema command"
echo "	mojopollo_laravel_json_schema"
echo "  nickCousins_schemaview_laravel"
echo "	laravel_schema_spy: generate schema relation spy with SchemaSpy"
echo "DbExporter command app/config/database.php"
echo "	php artisan dbe:migrations otherDatabaseName"
echo "	php artisan dbe:migrations --ignore=\"table1,table2\""
echo "	php artisan dbe:seeds"
echo "Uploading migrations/seeds to remote server app/config/remote.php"
echo "       php artisan dbe:remote production --migrations  #upload migrations to the production server"
echo "       php artisan dbe:remote production --seeds       #upload seeds to the production server"
echo "       php artisan dbe:remote production --migrations --seeds  #upload both to the production server"
