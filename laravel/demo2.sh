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
setdir e-commerce
$GIT https://github.com/mage2/laravel-ecommerce
$GIT https://github.com/dianpou/dianpou


setdir backend
$GIT https://github.com/qloog/laravel5-backend
$GIT https://github.com/6ag/jiansan-laravel
$GIT https://github.com/anlutro/laravel-repository  #integrate with github

setdir api
$GIT https://github.com/selahattinunlu/laravel-api-query-builder
$GIT https://github.com/OpenSkill/Datatable
$GIT https://github.com/heroicpixels/filterable
$GIT https://github.com/lijy91/daza-backend
$GIT https://github.com/engrnvd/laravel-crud-generator
$GIT https://github.com/teepluss/laravel-restable
$GIT https://github.com/php-tmdb/laravel
$GIT https://github.com/teepluss/laravel-restable
$GIT https://github.com/scotch-io/simple-laravel-crud
$GIT https://github.com/remoblaser/laravel-resourceful
$GIT https://github.com/merlosy/laravel-restful-api-starter

setdir admin
$GIT https://github.com/GeneaLabs/laravel-governor
$GIT https://github.com/RoumenDamianoff/laravel-assets
$GIT https://github.com/Brotzka/laravel-dotenv-editor
$GIT https://github.com/mathiasgrimm/laravel-env-validator
$GIT https://github.com/daftspunk/laravel-config-writer
$GIT https://github.com/SocialiteProviders/Manager
$GIT https://github.com/camroncade/timezone
$GIT https://github.com/efficiently/larasset
$GIT https://github.com/svenluijten/env-providers
$GIT https://github.com/phanan/cascading-config
$GIT https://github.com/JayBizzle/Laravel-Migrations-Organiser

setdir push
$GIT https://github.com/laravel-notification-channels/pusher-push-notifications
$GIT https://github.com/laravel-notification-channels/telegram
$GIT https://github.com/codecourse/notify


setdir sample
$GIT https://github.com/acoustep/entrust-gui
$GIT https://github.com/dtrenz/laravel-model-demo
$GIT https://github.com/jcc/vue-laravel-example
$GIT https://github.com/florentsorel/laravel-entrust-role-permission-panel
$GIT https://github.com/codex-project/codex
$GIT https://github.com/jaiwalker/setup-laravel5-package
$GIT https://github.com/Flynsarmy/laravel-5-todo-tutorial
$GIT https://github.com/lucid-architecture/laravel
$GIT https://github.com/msurguy/LaravelBackboneTodoMVC
$GIT https://github.com/bstrahija/laravel-modules-example
$GIT https://github.com/cmgmyr/laravel-messenger-pusher-demo
$GIT https://github.com/netcan/Laravel_AJAX_CRUD

setdir workflow
$GIT https://github.com/cerbero90/Workflow
 
setdir model
$GIT https://github.com/jarektkaczyk/Eloquent-triple-pivot  #many to many
$GIT https://github.com/cviebrock/eloquent-taggable
$GIT https://github.com/spatie/laravel-sluggable
$GIT https://github.com/dwightwatson/bootstrap-form
$GIT https://github.com/spatie/laravel-tags
$GIT https://github.com/Tucker-Eric/EloquentFilter
$GIT https://github.com/znck/belongs-to-through
$GIT https://github.com/sahusoftcom/eloquent-image-mutator
$GIT https://github.com/Nanigans/single-table-inheritance  #multi object map to one table
$GIT https://github.com/kladd/slim-eloquent
$GIT https://github.com/kodeine/laravel-meta
$GIT https://github.com/mojopollo/laravel-json-schema
$GIT https://github.com/AdrianSkierniewski/eloquent-tree
$GIT https://github.com/atayahmet/laravel-nestable
$GIT https://github.com/alsofronie/eloquent-uuid
$GIT https://github.com/rtconner/laravel-addresses
$GIT https://github.com/5-say/laravel-schema-extend

setdir queue
$GIT https://github.com/barryvdh/laravel-async-queue
$GIT https://github.com/illuminate/queue
$GIT https://github.com/oriceon/laravel-5-sockets-and-queue-async

setdir seo

$GIT https://github.com/jeroennoten/Laravel-Prerender #Render for SEO

setdir storage
$GIT https://github.com/spatie/laravel-cookie-consent  #EU cookie Law

setdir deploy
$GIT https://github.com/antonioribeiro/deeployer #deploy by github
$GIT https://github.com/papertank/envoy-deploy
$GIT https://github.com/nickfan/envoy-deployscript
$GIT https://github.com/JulienTant/Laravel-Env-Sync
$GIT https://github.com/GrahamCampbell/Laravel-Dropbox
$GIT https://github.com/edvinaskrucas/settings

setdir local
$GIT https://github.com/themsaid/laravel-multilingual
$GIT https://github.com/Anahkiasen/polyglot
$GIT https://github.com/rmariuzzo/Laravel-JS-Localization
$GIT https://github.com/BenConstable/laravel-localize-middleware
$GIT https://github.com/andywer/laravel-js-localization
$GIT https://github.com/spatie/laravel-translation-loader


setdir log
$GIT https://github.com/Regulus343/ActivityLog
$GIT https://github.com/spatie/laravel-tail
$GIT https://github.com/BootstrapCMS/LogViewer


setdir chat
$GIT https://github.com/dazzz1er/confer

setdir cms
$GIT https://github.com/monarkee/bumble
$GIT https://github.com/6ag/EnglishCommunity-laravel
$GIT https://github.com/dr-dimitru/indira


setdir auth
$GIT https://github.com/acoustep/entrust-gui
$GIT https://github.com/liaol/socialite-cn
$GIT https://github.com/cgrossde/Laraguard #protect controller and method
$GIT https://github.com/florentsorel/laravel-entrust-role-permission-panel
$GIT https://github.com/keevitaja/keeper-laravel
$GIT https://github.com/Volicon/laravel-acl-rbac
$GIT https://github.com/generationtux/jwt-artisan
$GIT https://github.com/vespakoen/authority-laravel
$GIT https://github.com/spatie/laravel-authorize
$GIT https://github.com/laracasts/laravel-5-roles-and-permissions-demo
$GIT https://github.com/SaschaDens/ldap-connector
$GIT https://github.com/rappasoft/vault
$GIT https://github.com/jeremykenedy/laravel-auth
$GIT https://github.com/codenitive/laravel-oneauth
$GIT https://github.com/ffsantos92/laracountries
$GIT https://github.com/vinkla/laravel-shield #http auth middleware
$GIT https://github.com/parin95/Laravel-Login
$GIT https://github.com/codingo-me/laravel-social-email-authentication
$GIT https://github.com/Toddish/Verify
$GIT https://github.com/laracasts/Email-Verification-In-Laravel
$GIT https://github.com/edvinaskrucas/laravel-user-email-verification

setdir mail
$GIT https://github.com/eventhomes/laravel-mandrillhooks
$GIT https://github.com/TheMonkeys/laravel-error-emailer


setdir file
$GIT https://github.com/tsawler/laravel-filemanager
$GIT https://github.com/intrip/laravel-import-export
$GIT https://github.com/vsmoraes/pdf-laravel5
$GIT https://github.com/zgldh/laravel-upload-manager

setdir validat
$GIT https://github.com/KennedyTedesco/Validation
$GIT https://github.com/crhayes/laravel-extended-validator
$GIT https://github.com/ShawnMcCool/laravel-form-base-model
$GIT https://github.com/andersao/laravel-validator
$GIT https://github.com/cerbero90/command-validator
$GIT https://github.com/Intervention/validation #isPassword, isISBNµÈ
$GIT https://github.com/schuppo/PasswordStrengthPackage
$GIT https://github.com/overtrue/validation  #used for non-laravel

setdir data
$GIT https://github.com/michaeldyrynda/laravel-cascade-soft-deletes # cascade delete
$GIT https://github.com/mpociot/reanimate #undo support
$GIT https://github.com/Askedio/laravel5-soft-cascade $undo redo
$GIT https://github.com/damiantw/laravel-scout-mysql-driver
$GIT https://github.com/Flynsarmy/laravel-csv-seeder
$GIT https://github.com/stidges/laravel-db-normalizer
$GIT https://github.com/alsofronie/eloquent-uuid
$GIT https://github.com/AntoineAugusti/laravel-easyrec # recommend server engine
$GIT https://github.com/thomastkim/laravel-online-users
$GIT https://github.com/thedevsaddam/laravel-schema

setdir utils
$GIT https://github.com/thedevsaddam/laravel-schema
$GIT https://github.com/dimsav/laravel-ip-service  # get country by ip
$GIT https://github.com/milon/barcode 
$GIT https://github.com/illuminate/contracts
$GIT https://github.com/harishanchu/Laravel-FTP
$GIT https://github.com/edvinaskrucas/settings
$GIT https://github.com/spatie/laravel-link-checker
$GIT https://github.com/illuminate/support
$GIT https://github.com/illuminate/container
$GIT https://github.com/recca0120/laravel-terminal
$GIT https://github.com/spatie/laravel-slack-slash-command
$GIT https://github.com/rafasamp/sonus #ffmpeg
$GIT https://github.com/vluzrmos/laravel-language-detector
$GIT https://github.com/dwightwatson/active

setdir monitor
$GIT https://github.com/nikkiii/status
$GIT https://github.com/spatie/laravel-uptime-monitor
$GIT https://github.com/michelecurletta/laravel-schedule-overview

setdir 3rd
$GIT https://github.com/florianv/laravel-swap
$GIT https://github.com/Torann/laravel-currency
$GIT https://github.com/Payum/PayumLaravelPackage

setdir ime
$GIT https://github.com/overtrue/laravel-pinyin

setadir route
$GIT https://github.com/sebastiaanluca/laravel-router
$GIT https://github.com/LaravelBA/route-binder
$GIT https://github.com/heroicpixels/filterable
$GIT https://github.com/dwightwatson/active
$GIT https://github.com/spatie/laravel-missing-page-redirector

setdir cmd
$GIT https://github.com/NickCousins/SchemaViewLaravel

setdir view
$GIT https://github.com/evercode1/view-maker
$GIT https://github.com/Maatwebsite/Laravel-Sidebar
$GIT https://github.com/mmochetti/LaraVueTchetChat
$GIT https://github.com/msurguy/laravel-ajax-example
$GIT https://github.com/Nayjest/Grids
$GIT https://github.com/jeroennoten/Laravel-AdminLTE
$GIT https://github.com/iroben/laravel5-amazeui-admin
$GIT https://github.com/Crinsane/LaravelCalendar
$GIT https://github.com/StydeNet/blade-pagination
$GIT https://github.com/jenssegers/blade
$GIT https://github.com/DarkaOnLine/L5-Swagger
$GIT https://github.com/Landish/Pagination
$GIT https://github.com/mgallegos/laravel-jqgrid
$GIT https://github.com/msieprawski/resource-table
$GIT https://github.com/karlomikus/theme
$GIT https://github.com/Flynsarmy/laravel-db-blade-compiler
$GIT https://github.com/pingpong-labs/menus

setdir chart
$GIT https://github.com/msurguy/laravel-charts
$GIT https://github.com/rktaiwala/Shpcart
$GIT https://github.com/fxcosta/laravel-chartjs


setdir gen
$GIT https://github.com/Maatwebsite/Laravel-Sidebar
$GIT https://github.com/ignasbernotas/laravel-model-generator
$GIT https://github.com/dwightwatson/bootstrap-form
$GIT https://github.com/caffeinated/menus
$GIT https://github.com/webNeat/lumen-generators
$GIT https://github.com/ChuckHeintzelman/laravel-recipes 
$GIT https://github.com/drawmyattention/laravel-make-resource
$GIT https://github.com/efficiently/larasset
$GIT https://github.com/mojopollo/laravel-json-schema
$GIT https://github.com/jenssegers/model
$GIT https://github.com/RobinMalfait/Laravel-auto-form-generator
$GIT https://github.com/evercode1/view-maker  #View maker

setdir image 
$GIT https://github.com/maikeldaloo/Resizer

setdir blog
$GIT https://github.com/moell-peng/moell-blog
$GIT https://github.com/msurguy/critterapp

