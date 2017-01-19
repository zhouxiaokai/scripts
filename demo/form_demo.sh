#!/bin/sh

. ./include/help.sh

print_color "https://github.com/kristijanhusak/laravel-form-builder"

form_controller(){
echo $@
local wdir=$1
 [ -d $wdir/app/Http/Controllers ] || mkdir -p $wdir/app/Http/Controllers
echo "

<?php

namespace App\Http\Controllers;

use Illuminate\Routing\Controller as BaseController;
use Kris\LaravelFormBuilder\FormBuilder;

class SongsController extends BaseController {

    public function create(FormBuilder \$formBuilder)
    {
        \$form = \$formBuilder->create(App\Forms\SongForm::class, [
            'method' => 'POST',
            'url' => route('song.store')
        ]);

        return view('song.create', compact('form'));
    }

    public function store(FormBuilder \$formBuilder)
    {
        \$form = \$formBuilder->create(App\Forms\SongForm::class);

        if (!\$form->isValid()) {
            return redirect()->back()->withErrors(\$form->getErrors())->withInput();
        }

        // Do saving and other things...
    }
}  

" > $wdir/app/Http/Controllers/SongsController.php

}

form_route(){
  local wdir=$1
  [ -d $wdir/routes ] || mkdir -p $wdir/routes 
  echo "
   Route::get('songs/create', [
    'uses' => 'SongsController@create',
    'as' => 'song.create'
]);

Route::post('songs', [
    'uses' => 'SongsController@store',
    'as' => 'song.store'
]);
" >> $wdir/routes/web.php
}

form_view(){
  local wdir=$1
  [ -d $wdir/resources/views/song ] || mkdir -p $wdir/resources/views/song
echo "
@extends('app')

@section('content')
    {!! form(i\$form) !!}
@endsection

" > $wdir/resources/views/song/create.blade.php

}

form_demo(){

local wdir=$1
 cd $wdir || exit 1
 php artisan make:form Forms/SongForm --fields="name:text, lyrics:textarea, publish:checkbox"
 
}
form_demo $@
form_controller $@
form_route $@
form_view $@
