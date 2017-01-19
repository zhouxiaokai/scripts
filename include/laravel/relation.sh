#!/bin/sh

skybluesofa_laravel_followers(){

   print_color "https://github.com/skybluesofa/laravel-followers"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor/ ] && {
    	composer require skybluesofa/laravel-followers
   }
   config_app_insert $wdir      "Skybluesofa\\\Followers\\\ServiceProvider::class"
   [ -d ./vendor ] && {
        php artisan vendor:publish --provider="Skybluesofa\Followers\ServiceProvider"
  	php artisan migrate
   }
}

laravel_friendships(){

   print_color "https://github.com/hootlex/laravel-friendships"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor/ ] && {
   	composer require hootlex/laravel-friendships
   }
   config_app_insert $wdir      "Hootlex\\\Friendships\\\FriendshipsServiceProvider::class"
   [ -d ./vendor ] && {
	php artisan vendor:publish --provider="Hootlex\Friendships\FriendshipsServiceProvider"        
	php artisan migrate
   }
}

arubacao_friends(){

   print_color "https://github.com/arubacao/friends"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor/ ] && {
	composer require arubacao/friends
   }
   config_app_insert $wdir      "Arubacao\\\Friends\\\FriendsServiceProvider::class"
   [ -d ./vendor ] && {
      	php artisan vendor:publish --provider="Arubacao\Friends\FriendsServiceProvider"
	php artisan migrate
   }
}

bkwld_cloner(){

   print_color "https://github.com/BKWLD/cloner"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor/ ] && {
   	composer require bkwld/cloner
   }
   config_app_insert $wdir      "Bkwld\\\Cloner\\\ServiceProvider::class"
   [ -d ./vendor ] && {
      php artisan vendor:publish --provider="Bkwld\Cloner\ServiceProvider"
   }
}

tucker_eric_eloquentfilter(){

   print_color "https://github.com/Tucker-Eric/EloquentFilter"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor/ ] && {
	composer require tucker-eric/eloquentfilter
   }
   config_app_insert $wdir 	"EloquentFilter\\\ServiceProvider::class"
   [ -d ./vendor ] && {
      php artisan vendor:publish --provider="EloquentFilter\ServiceProvider"
   }
}

znck_plug(){

   print_color "https://github.com/znck/plug"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor/ ] && {
      composer require znck/plug
   }

}

znck_belongs_to_through(){


   print_color "https://github.com/znck/plug"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor/ ] && {
       composer require znck/belongs-to-through 
   }

}

   
laravel_custom_relation(){
   print_color https://github.com/johnnyfreeman/laravel-custom-relation
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor/ ] && {
      composer require johnnyfreeman/laravel-custom-relation
   }
}  


laravel_relationship_test(){
   print_color "https://github.com/fs-ap/laravel-relationship-test"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor/ ] && {
     composer require --dev fs-ap/laravel-relationship-test:~1.0
   }
}


tjbp_eloquent_joins(){
   print_color "https://github.com/tjbp/eloquent-joins"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor/tjbp/eloquent-joins ] || {
         mkdir -p ./vendor/tjbp/eloquent-joins
         cd ./vendor/tjbp
         git clone https://github.com/tjbp/eloquent-joins eloquent-joins || {
            popd
            exit 1
          }
        cd ../../
   }
   classmap_insert     $wdir "vendor/tjbp/eloquent-joins/"
   [ -d ./vendor ] && composer dump-autoload
}

echo "Friendship"
echo "	skybluesofa_laravel_followers: Gives Eloquent models the ability to manage their followers"
echo "	laravel_friendships: this package gives Eloquent models the ability to manage their friendshipsips:"
echo "	arubacao_friends:Organise Friends and Relationships Between Users in Laravel and Lumen"
echo "	tjbp_eloquent_joins:  join a Laravel Eloquent relationship's table on the keys declared by your relationship"
echo "Model Clone"
echo "	bkwld_cloner:A trait for Laravel Eloquent models that lets you clone a model and it's relationships, including files. Even to another database"   
echo "Model Filter with Replation support"
echo "	tucker_eric_eloquentfilter:An Eloquent way to filter Eloquent Models and their relationships"
echo "		php artisan model:filter AdminFilters\\User"
echo "Relation Pkg:"
echo "  laravel_custom_relation: A custom relation for when stock relations aren't enough"
echo "	laravel_relationship_test: Relationship::check(Author::class, Relationship::HAS_MANY, Comment::class));"
echo "  znck_belongs_to_through:Inverse of HasManyThrough relation is missing from Laravel's ORM"
echo "  znck_plug: A collection of pluggable Eloquent traits to enhance your Models"
