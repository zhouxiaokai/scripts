#!/bin/sh

tdir=$1
[ -d $tdir  ] || {
  echo "$tdir not exist"
  exit 1
}


[ $# -lt 1 ] && {
  echo "$0 [dir full path start by / ]"
  exit 1
}

setdir(){
 local sdir=$0
[ -d $tdir/$sdir ] || mkdir -p $tdir/$sdir && cd $tdir/$sdir

}

GIT="git clone --depth=1"

setdir api
$GIT https://github.com/helei112g/laravel-swagger  #api autogen
$GIT https://github.com/slampenny/Swaggervel

setdir sample
$GIT https://github.com/sseffa/fullycms
$GIT https://github.com/TypiCMS/Base
$GIT https://github.com/LaravelRUS/SleepingOwlAdmin
$GIT https://github.com/SleepingOwlAdmin/demo
$GIT https://github.com/zofe/rapyd-laravel
$GIT https://github.com/crocodic-studio/crudbooster
$GIT https://github.com/sroutier/laravel-enterprise-starter-kit
$GIT https://github.com/bestmomo/laravel5-3-example
$GIT https://github.com/luisedware/CowCat
$GIT https://github.com/serverfireteam/panel
$GIT https://github.com/yajra/laravel-datatables-demo
$GIT https://github.com/LaravelDaily/quickadmin
$GIT https://github.com/liukaijv/laravel-vue-cms
$GIT https://github.com/sdfsky/tipask
$GIT https://github.com/rose1988c/Laravel-Bootstrap-Admin-Template
$GIT https://github.com/huijimuhe/monolog-web
$GIT https://github.com/TahaSh/spa-forum
$GIT https://github.com/argb/laravel-ueditor
$GIT https://github.com/laraflock/dashboard
$GIT https://github.com/w3nh4o/Laravel-5-with-bootstrap-responsive-admin-template-AdminLTE
$GIT https://github.com/bohan1115/metronic_laravel_admin
$GIT https://github.com/audeSt/ProjectManagerSystem
$GIT https://github.com/big-pang/laravel5.2-Admin
$GIT https://github.com/yhbyun/laravel-bookmark
$GIT https://github.com/stevenyangecho/laravel-u-editor
$GIT https://github.com/yccphp/laravel-5-markdown-editor
$GIT https://github.com/tyua07/laravel-admin
$GIT https://github.com/dwijitsolutions/laraadmin
$GIT https://github.com/LavaLite/cms

$GIT https://github.com/acacha/adminlte-laravel
$GIT https://github.com/snipe/snipe-it
$GIT https://github.com/invoiceninja/invoiceninja 

setdir file
$GIT https://github.com/bestmomo/filemanager

setdir admin
$GIT https://github.com/iBourgeois/LaraEdit

setdir validat
$GIT https://github.com/joecwallace/jquery-validator
$GIT https://github.com/ppoffice/validator.js

setdir cmd
$GIT https://github.com/dydx/Laravel-5-Artisan
$GIT https://github.com/cruddy/cruddy

setdir mail
$GIT https://github.com/Snowfire/Beautymail

setdir file
$GIT https://github.com/Pasvaz/laravel-juploader
$GIT https://github.com/zimt28/laravel-jquery-file-upload
$GIT https://github.com/guillermomartinez/filemanager-laravel
$GIT https://github.com/jildertmiedema/laravel-plupload


setdir workflow
$GIT https://github.com/laracasts/Vue-and-Laravel-Workflow
$GIT https://github.com/whipsterCZ/laravel-ajax
$GIT https://github.com/kuroski/Laravel-Vue-Boilerplate
$GIT https://github.com/Media24si/vue-pagination
$GIT https://github.com/cklmercer/vue-laravel-forms
$GIT https://github.com/JellyBool/laravel-vue-pagination
$GIT https://github.com/zgldh/vuejs-laravel

setdir auth
$GIT https://github.com/goodspb/laravel-user-center
$GIT https://github.com/yuansir/laravel5-rbac-example


setdir widget
$GIT https://github.com/RyanSMurphy/Laravel-Bootstrap-Modal-Form
$GIT https://github.com/Infinety/laravel-sweet-alert

setdir debug
$GIT https://github.com/recca0120/laravel-tracy
$GIT https://github.com/lsrur/inspector
$GIT https://github.com/darsain/laravel-console

setdir view
$GIT https://github.com/yccphp/pjax-for-laravel-5

setdir chart
$GIT https://github.com/ConsoleTVs/Charts
