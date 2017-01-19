#!/bin/sh

laravel_translator(){
   print_color "https://github.com/vinkla/laravel-translator"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
   	composer require vinkla/translator || exit 
   }
   
}

barryvdh_laravel_translation_manager ()
{
   print_color "https://github.com/barryvdh/laravel-translation-manager"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
         composer require barryvdh/laravel-translation-manager || exit 1
   }
   config_app_insert        $wdir     "Barryvdh\\\TranslationManager\\\ManagerServiceProvider::class"
   [ -d ./vendor ] && {
     php artisan vendor:publish --provider="Barryvdh\TranslationManager\ManagerServiceProvider" --tag=migrations
     php artisan vendor:publish --provider="Barryvdh\TranslationManager\ManagerServiceProvider" --tag=config
     php artisan vendor:publish --provider="Barryvdh\TranslationManager\ManagerServiceProvider" --tag=views
     php artisan migrate
   }
   popd
}

themsaid_laravel_langman(){
   print_color "https://github.com/themsaid/laravel-langman"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
         composer require themsaid/laravel-langman || exit 1
   }
   config_app_insert        $wdir     "Themsaid\\\Langman\\\LangmanServiceProvider::class"
   [ -d ./vendor ] &&   {
    php artisan vendor:publish --provider="Themsaid\Langman\LangmanServiceProvider"
   }
   popd
}

tjbp_countries(){
   print_color "https://github.com/tjbp/php-countries"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor/tjbp/php-countries ] || {
         mkdir -p ./vendor/tjbp/php-countries
         cd ./vendor/tjbp
         git clone https://github.com/tjbp/php-countries php-countries || {
            popd
            exit 1
          }
        cd ../../
   }
   classmap_insert     $wdir "vendor/tjbp/php-countries/"
   [ -d ./vendor ] && composer dump-autoload
}


ffsantos92_laracountries(){
   print_color "https://github.com/ffsantos92/laracountries"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./tmp ] || mkdir -p ./tmp
   [ -d ./tmp/laracountries ] || {
     cd ./tmp
     git clone https://github.com/ffsantos92/laracountries || exit 1
     cp laracountries/database/* -rdf ../database/ || exit 1
     cd ../
   }
   echo "here is `pwd`" 
   [ -d ./vendor ] &&   {
      echo '
<select class="form-control" name="country">
    <option value="">Select a country</option>
    @foreach($countries as $country)
        <option value="{{ $country->id }}">{{ $country->name }}</option>
    @endforeach
</select>
' > ./resources/views/includes/countries.blade.php
     echo "<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Model;

class Country extends Model
{
    protected \$table = 'countries';
    public \$timestamps = false;
}
 "> ./app/Models/Country.php
 echo "<?php

namespace App\Http\Controllers;

use App\Models\Country;
use Illuminate\Http\Request;
class CountryController extends Controller
{
/**
 * Show the form for creating a new resource.
 *
 * @return View
 */
 	public function create()
 	{
    		\$countries = Country::all();

    		return view('includes/countries', compact('countries'));
 	}
}

" > ./app/Http/Controllers/CountryController.php
}   
   
}
echo "Laravel local package:"
echo "	Local Data:"
echo "	tjbp_countries: ISO 3166 country data"
echo "	ffsantos92_laracountries:"
echo "	laravel_translator:An Eloquent translator for Laravel"
echo "barryvdh_laravel_translation_manager"
echo "		php artisan translations:import"
echo "		php artisan translations:find"
echo "		php artisan translations:export reminders"
echo "		php artisan translations:clean"
echo "		php artisan translations:reset"

echo "themsaid_laravel_langman"
echo "		php artisan langman:show users"
echo "		php artisan langman:show users.name"
echo "		php artisan langman:show users.name.first"
echo "		php artisan langman:show package::users.name"
echo "		php artisan langman:show users --lang=en,it"
echo "		php artisan langman:show users.nam -c"
echo "		php artisan langman:find 'log in first'"
echo "		php artisan langman:sync"
echo "		php artisan langman:missing"
echo "		php artisan langman:trans users.name"
echo "          php artisan langman:trans users.name.first"
echo "          php artisan langman:trans users.name --lang=en"
echo "          php artisan langman:trans package::users.name"
echo "		php artisan langman:remove users.name"
echo "          php artisan langman:remove package::users.name"
echo "		php artisan langman:rename users.name full_name"
