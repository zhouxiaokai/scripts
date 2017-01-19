#!/bin/sh

. ./include/help.sh
print_color "https://github.com/Distilleries/DatatableBuilder"

wdir=$1

cd $wdir || exit 1

php artisan datatable:make Datatables/UserDatatable --fields="name, email"


controller(){

echo "?php namespace App\Http\Controllers;

use App\Datatables\UserDatatable;

class DatatableController extends Controller {

    use \Distilleries\DatatableBuilder\States\DatatableStateTrait;
    /*
    |--------------------------------------------------------------------------
    | Welcome Controller
    |--------------------------------------------------------------------------
    |
    | This controller renders the "marketing page" for the application and
    | is configured to only allow guests. Like most of the other sample
    | controllers, you are free to modify or remove it as you desire.
    |
    */

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct(\App\User \$model, UserDatatable \$datatable)
    {
        \$this->model = \$model;
        \$this->datatable = \$datatable;
    }

    /**
     * Show the application welcome screen to the user.
     *
     * @return Response
     */
    public function getIndex()
    {
        return view('welcome',[
            'datatable'=>\$this->getIndexDatatable()
        ]);
    }

}
" > $wdir/app/Http/Controllers/DatatableController.php


}

echo "
Route::get('datatable', [
    'uses' => 'DatatableController@getIndex',
    'as' => 'song.index'
]);

" >> $wdir/routes/web.php

controller $1





