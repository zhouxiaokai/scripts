#!/bin/sh

tdir=$1
[ $# -lt 1 ] && {
  echo "$0 [dir]"
  exit 1
}
[ -d $tdir/cms ] || mkdir -p $tdir/cms
cd $tdir/cms
git clone --depth=1 https://github.com/pyrocms/pyrocms/tree/master/routes
git clone --depth=1 https://github.com/octobercms/october
git clone --depth=1 https://github.com/BootstrapCMS/CMS
git clone --depth=1 https://github.com/YABhq/Quarx


[ -d $tdir/api ] || mkdir -p $tdir/api
cd $tdir/api 
git clone --depth=1 https://github.com/rcrowe/TwigBridge
git clone --depth=1 https://github.com/Porto-SAP/Hello-API
git clone --depth=1 https://github.com/mpociot/laravel-apidoc-generator
git clone --depth=1 https://github.com/mitulgolakiya/laravel-api-generator
git clone --depth=1 https://github.com/dingo/api
git clone --depth=1 https://github.com/chrisbjr/api-guard
git clone --depth=1 https://github.com/appzcoder/crud-generator
git clone --depth=1 https://github.com/GrahamCampbell/Laravel-Throttle
git clone --depth=1 https://github.com/HipsterJazzbo/Landlord
git clone --depth=1 https://github.com/francescomalatesta/laravel-api-boilerplate-jwt
git clone --depth=1 https://github.com/skyronic/crudkit
git clone --depth=1 https://github.com/nilportugues/laravel5-jsonapi
git clone --depth=1 https://github.com/egeriis/laravel-jsonapi

git clone --depth=1 https://github.com/flugger/laravel-responder
git clone --depth=1 https://github.com/asvae/laravel-api-tester
[ -d $tdir/gen ] || mkdir -p $tdir/gen
cd $tdir/gen
git clone --depth=1 https://github.com/adamwathan/bootforms
git clone --depth=1 https://github.com/formers/former
git clone --depth=1 https://github.com/JeffreyWay/Laravel-4-Generators
git clone --depth=1 https://github.com/laracasts/Laravel-5-Generators-Extended
git clone --depth=1 https://github.com/InfyOmLabs/laravel-generator #与metronic结合
git clone --depth=1 https://github.com/formers/former
git clone --depth=1 https://github.com/kristijanhusak/laravel-form-builder
git clone --depth=1 https://github.com/Xethron/migrations-generator
git clone --depth=1 https://github.com/barryvdh/laravel-migration-generator
git clone --depth=1 https://github.com/laracademy/generators

git clone --depth=1 https://github.com/lavary/laravel-menu
git clone --depth=1 https://github.com/spatie/laravel-menu
git clone --depth=1 https://github.com/GeneaLabs/laravel-caffeine
git clone --depth=1 https://github.com/msurguy/laravel-shop-menu
git clone --depth=1 https://github.com/StydeNet/html #generate html

 [ -d $tdir/auth ] || mkdir -p $tdir/auth
cd $tdir/auth
git clone --depth=1 https://github.com/santigarcor/laratrust
git clone --depth=1 https://github.com/overtrue/socialite
git clone --depth=1 https://github.com/unicodeveloper/laravel-password
git clone --depth=1 https://github.com/chrisbjr/api-guard
git clone --depth=1 https://github.com/spatie/laravel-permission
git clone --depth=1 https://github.com/Zizaco/entrust
git clone --depth=1 https://github.com/romanbican/roles
git clone --depth=1 https://github.com/tymondesigns/jwt-auth
git clone --depth=1 https://github.com/irazasyed/jwt-auth-guard

git clone --depth=1 https://github.com/adamwathan/eloquent-oauth
git clone --depth=1 https://github.com/lucadegasperi/oauth2-server-laravel
git clone --depth=1 https://github.com/adamwathan/eloquent-oauth-l5
git clone --depth=1 https://github.com/kodeine/laravel-acl
git clone --depth=1 https://github.com/JosephSilber/bouncer
git clone --depth=1 https://github.com/ollieread/multiauth
git clone --depth=1 https://github.com/artesaos/defender
git clone --depth=1 https://github.com/greggilbert/recaptcha
git clone --depth=1 https://github.com/mewebstudio/captcha
git clone --depth=1 https://github.com/anhskohbo/no-captcha
git clone --depth=1 https://github.com/toplan/laravel-sms
git clone --depth=1 https://github.com/jrean/laravel-user-verification

git clone --depth=1 https://github.com/spatie/laravel-activitylog 
git clone --depth=1 https://github.com/antonioribeiro/firewall
git clone --depth=1 https://github.com/intrip/laravel-authentication-acl
git clone --depth=1 https://github.com/spatie/laravel-url-signer

git clone --depth=1 https://github.com/efficiently/authority-controller #用户资源控制

[ -d $tdir/notification ] || mkdir -p $tdir/notification
cd $tdir/notification
git clone --depth=1 https://github.com/davibennun/laravel-push-notification
git clone --depth=1 https://github.com/cmgmyr/laravel-messenger
git clone --depth=1 https://github.com/fenos/Notifynder
git clone --depth=1 https://github.com/tylercd100/lern
git clone --depth=1 https://github.com/jenssegers/laravel-rollbar
git clone --depth=1 https://github.com/Indatus/dispatcher
git clone --depth=1 https://github.com/mpociot/captainhook
git clone --depth=1 https://github.com/maknz/slack
git clone --depth=1 https://github.com/thekordy/ticketit  #叫号系统 
git clone --depth=1 https://github.com/timegridio/timegrid #预约系统
git clone --depth=1 https://github.com/vinkla/laravel-pusher
git clone --depth=1 https://github.com/vladimir-yuldashev/laravel-queue-rabbitmq
git clone --depth=1 https://github.com/cmosguy/laravel-http-pushstream-broadcaster
git clone --depth=1 https://github.com/cretueusebiu/laravel-web-push-demo
git clone --depth=1 https://github.com/JacobBennett/laravel-HTTP2ServerPush

[ -d $tdir/admin ] || mkdir -p $tdir/admin
cd $tdir/admin
git clone --depth=1 https://github.com/owen-it/laravel-auditing  #记录model改变日志
git clone --dpeth=1 https://github.com/YABhq/Laracogs
git clone --depth=1 https://github.com/FrozenNode/Laravel-Administrator
git clone --depth=1 https://github.com/the-control-group/voyager
git clone --depth=1 https://github.com/themsaid/laravel-langman
git clone --depth=1 https://github.com/barryvdh/laravel-translation-manager
git clone --depth=1 https://github.com/CodeSleeve/laravel-stapler
git clone --depth=1 https://github.com/z-song/laravel-admin
git clone --depth=1 https://github.com/nWidart/laravel-modules
git clone --depth=1 https://github.com/LaravelRUS/SleepingOwlAdmin
git clone --depth=1 https://github.com/Jeroen-G/laravel-packager
git clone --depth=1 https://github.com/VentureCraft/revisionable
git clone --depth=1 https://github.com/rocketeers/rocketeer #云部署
git clone --depth=1 https://github.com/anlutro/laravel-settings #应用配置
git clone --depth=1 https://github.com/Phil-F/Setting
git clone --depth=1 https://github.com/svenluijten/artisan-view
git clone --depth=1 https://github.com/mpociot/versionable
git clone --depth=1 https://github.com/mathiasgrimm/laravel-dot-env-gen

[ -d $tdir/file ] || mkdir -p $tdir/file
cd $tdir/file
git clone --depth=1 https://github.com/barryvdh/laravel-dompdf
git clone --depth=1 https://github.com/Maatwebsite/Laravel-Excel
git clone --depth=1 https://github.com/Crinsane/LaravelShoppingcart
git clone --depth=1 https://github.com/barryvdh/laravel-snappy
git clone --depth=1 https://github.com/plank/laravel-mediable
git clone --depth=1 https://github.com/SoapBox/laravel-formatter

[ -d $tdir/local ] || mkdir -p $tdir/local
cd $tdir/local
git clone --depth=1 https://github.com/dimsav/laravel-translatable 
git clone --depth=1 https://github.com/mcamara/laravel-localization
git clone --depth=1 https://github.com/webpatser/laravel-countries
git clone --depth=1 https://github.com/overtrue/laravel-lang
git clone --depth=1 https://github.com/Waavi/translation

[ -d $tdir/model ] || mkdir -p $tdir/model
cd $tdir/model
git clone --depth=1 https://github.com/lukepolo/laracart #购物车 礼券，税费，配送 价格 
git clone --depth=1 https://github.com/dwightwatson/validating
git clone --depth=1 https://github.com/proengsoft/laravel-jsvalidation
git clone --depth=1 https://github.com/cviebrock/image-validator
git clone --depth=1 https://github.com/felixkiss/uniquewith-validator
git clone --depth=1 https://github.com/JeffreyWay/Laravel-Model-Validation
git clone --depth=1 https://github.com/Propaganistas/Laravel-Phone

git clone --depth=1 https://github.com/cviebrock/eloquent-sluggable
git clone --depth=1 https://github.com/jenssegers/laravel-mongodb
git clone --depth=1 https://github.com/rtconner/laravel-tagging
git clone --depth=1 https://github.com/Chumper/Datatable
git clone --depth=1 https://github.com/elasticquent/Elasticquent
git clone --depth=1 https://github.com/laravel-doctrine/orm 
git clone --depth=1 https://github.com/spatie/laravel-responsecache

git clone --depth=1 https://github.com/hootlex/laravel-friendships
git clone --depth=1 https://github.com/kirkbushell/eloquence
git clone --depth=1 https://github.com/TomLingham/Laravel-Searchy
git clone --depth=1 https://github.com/mmanos/laravel-search
git clone --depth=1 https://github.com/shift31/laravel-elasticsearch
git clone --depth=1 https://github.com/msurguy/laravel-smart-search

git clone --depth=1 https://github.com/dwightwatson/rememberable
git clone --depth=1 https://github.com/vinkla/laravel-translator

git clone --depth=1 https://github.com/artisaninweb/laravel-soap

git clone --depth=1 https://github.com/laralib/l5scaffold
git clone --depth=1 https://github.com/leroy-merlin-br/mongolid-laravel
git clone --depth=1 https://github.com/sleimanx2/plastic
git clone --depth=1 https://github.com/spatie/laravel-translatable
git clone --depth=1 https://github.com/rtconner/laravel-likeable

[ -d $tdir/data ] || mkdir -p $tdir/data
cd $tdir/data
git clone --depth=1 https://github.com/nWidart/DbExporter #跨机器数据同步
git clone --depth=1 https://github.com/hootlex/laravel-moderation #内容审核
git clone --depth=1 https://github.com/fitztrev/query-tracer 
git clone --depth=1 https://github.com/slampenny/SmartSeeder
git clone --depth=1 https://github.com/franzose/ClosureTable
git clone --depth=1 https://github.com/orchestral/tenanti #Multi-tenant Database Schema Manager
git clone --depth=1 https://github.com/cviebrock/sequel-pro-laravel-export 

[ -d $tdir/sample ] || mkdir -p $tdir/sample
cd $tdir/sample
git clone --depth=1 https://github.com/summerblue/laravel-package-top-100
git clone --depth=1 https://github.com/jp7internet/laravel-apz
git clone --depth=1 https://github.com/layer7be/vue-starter-laravel-api
git clone --depth=1 https://github.com/bestmomo/laravel5-example
git clone --depth=1 https://github.com/brunogaspar/laravel-starter-kit
git clone --depth=1 https://github.com/vinkla/laravel-hashids
git clone --depth=1 https://github.com/orangehill/iseed
git clone --depth=1 https://github.com/laravelio/laravel.io
git clone --depth=1 https://github.com/CodepadME/laravel-tricks
git clone --depth=1 https://github.com/lazychaser/laravel-nestedset
git clone --depth=1 https://github.com/Anahkiasen/underscore-php
git clone --depth=1 https://github.com/talyssonoc/react-laravel
git clone --depth=1 https://github.com/summerblue/laravel5-cheatsheet
git clone --depth=1 https://github.com/bllim/laravel4-datatables-package
git clone --depth=1 https://github.com/spatie/laravel-pjax


[ -d $tdir/utils ] || mkdir -p $tdir/utils
cd $tdir/utils
git clone --depth=1 https://github.com/fitztrev/laravel-html-minify
git clone --depth=1 https://github.com/Torann/laravel-geoip
git clone --depth=1 https://github.com/geocoder-php/GeocoderLaravel
git clone --depth=1 https://github.com/geocoder-php/GeocoderLaravel
git clone --depth=1 https://github.com/hisorange/browser-detect
git clone --depth=1 https://github.com/webpatser/laravel-uuid
git clone --depth=1 https://github.com/liebig/cron
git clone --depth=1 https://github.com/spatie/laravel-backup
git clone --depth=1 https://github.com/SimpleSoftwareIO/simple-qrcode
git clone --depth=1 https://github.com/Chumper/Zipper

git clone --depth=1 https://github.com/ericmakesstuff/laravel-server-monitor
git clone --depth=1 https://github.com/spatie/laravel-fractal
git clone --depth=1 https://github.com/BKWLD/croppa
git clone --depth=1 https://github.com/Intervention/image

git clone --depth=1 https://github.com/fideloper/TrustedProxy
git clone --depth=1 https://github.com/GrahamCampbell/Laravel-Exceptions
git clone --depth=1 https://github.com/orchestral/testbench
git clone --depth=1 https://github.com/mpociot/laravel-test-factory-helper
git clone --depth=1 https://github.com/jenssegers/laravel-ab

git clone --depth=1 https://github.com/mpociot/captainhook
git clone --depth=1 https://github.com/LaravelCollective/remote
git clone --depth=1 https://github.com/rap2hpoutre/laravel-log-viewer
git clone --depth=1 https://github.com/ARCANEDEV/LogViewer
git clone --depth=1 https://github.com/andersao/laravel-request-logger

git clone --depth=1 https://github.com/jenssegers/date
git clone --depth=1 https://github.com/laracasts/PHP-Vars-To-Js-Transformer
git clone --depth=1 https://github.com/itsgoingd/clockwork
git clone --depth=1 https://github.com/spatie/laravel-failed-job-monitor
git clone --depth=1 https://github.com/spatie/laravel-collection-macros

git clone --depth=1 https://github.com/BeatSwitch/lock-laravel
git clone --depth=1 https://github.com/ipunkt/laravel-analytics

[ -d $tdir/e-commerce ] || mkdir -p $tdir/e-commerce
cd $tdir/e-commerce
git clone --depth=1 https://github.com/aimeos/aimeos-laravel
git clone --depth=1 https://github.com/Crinsane/LaravelShoppingcart
git clone --depth=1 https://github.com/ant-vel/antVel 
git clone --depth=1 https://github.com/lavender/lavender
git clone --depth=1 https://github.com/amsgames/laravel-shop
git clone --depth=1 https://github.com/darryldecode/laravelshoppingcart
git clone --depth=1 https://github.com/Bottelet/Flarepoint-crm #客户关系
git clone --depth=1 https://github.com/stevebauman/inventory  #进销存

[ -d $tdir/3rd ] || mkdir -p $tdir/3rd
cd $tdir/3rd 

git clone --depth=1 https://github.com/anouarabdsslm/laravel-paypalpayment
git clone --depth=1 https://github.com/ignited/laravel-omnipay
git clone --depth=1 https://github.com/huanghua581/laravel-wechat-sdk #WeChat
git clone --dpeth=1 https://github.com/johnlui/AliyunOSS

[ -d $tdir/blog ] || mkdir -p $tdir/blog
cd $tdir/blog
git clone --depth=1 https://github.com/yccphp/laravel-5-blog
git clone --depth=1 https://github.com/Hifone/Hifone
git clone --depth=1 https://github.com/mpociot/teamwork
git clone --depth=1 https://github.com/lufficc/Xblog
git clone --depth=1 https://github.com/spatie/laravel-newsletter
git clone --depth=1 https://github.com/GitaminHQ/Gitamin
git clone --depth=1 https://github.com/Riari/laravel-forum
git clone --depth=1 https://github.com/thedevdojo/chatter
git clone --depth=1 https://github.com/GetStream/stream-laravel

[ -d $tdir/route ] || mkdir -p $tdir/route
cd $tdir/route

git clone --depth=1 https://github.com/aaronlord/laroute
git clone --depth=1 https://github.com/liebig/cron
git clone --depth=1 https://github.com/backup-manager/laravel
git clone --depth=1 https://github.com/spatie/laravel-responsecache
git clone --depth=1 https://github.com/spatie/laravel-url-signer
git clone --depth=1 https://github.com/barryvdh/laravel-httpcache
git clone --depth=1 https://github.com/LaravelCollective/annotations
git clone --depth=1 https://github.com/letrunghieu/active
git clone --depth=1 https://github.com/hyn/multi-tenant
git clone --depth=1 https://github.com/HipsterJazzbo/laravel-multi-tenant

git clone --depth=1 https://github.com/scil/LaravelFly

git clone --depth=1 https://github.com/letrunghieu/active
git clone --depth=1 https://github.com/LaravelCollective/annotations
git clone --depth=1 https://github.com/spatie/laravel-paginateroute

[ -d $tdir/view ] || mkdir -p $tdir/view
cd $tdir/view
git clone --depth=1 https://github.com/teepluss/laravel-theme
git clone --depth=1 https://github.com/igaster/laravel-theme

git clone --depth=1 https://github.com/patricktalmadge/bootstrapper
git clone --depth=1 https://github.com/tightenco/jigsaw
git clone --depth=1 https://github.com/GrahamCampbell/Laravel-Markdown
git clone --depth=1 https://github.com/spatie-custom/blender
git clone --depth=1 https://github.com/PhiloNL/Laravel-Blade
git clone --depth=1 https://github.com/RobinRadic/blade-extensions

git clone --depth=1 https://github.com/uxweb/sweet-alert
git clone --depth=1 https://github.com/slampenny/Swaggervel
git clone --depth=1 https://github.com/fedeisas/laravel-mail-css-inliner
git clone --depth=1 https://github.com/kevinkhill/lavacharts
git clone --depth=1 https://github.com/mewebstudio/Purifier
git clone --depth=1 https://github.com/davejamesmiller/laravel-breadcrumbs
git clone --depth=1 https://github.com/maddhatter/laravel-fullcalendar
git clone --depth=1 https://github.com/arrilot/laravel-widgets
git clone --depth=1 https://github.com/marvinlabs/laravel-setup-wizard
git clone --depth=1 https://github.com/toin0u/Geotools-laravel

git clone --depth=1 https://github.com/msalom28/Larasocial #rich web social app
git clone --depth=1 https://github.com/spatie/laravel-blade-javascript

git clone --depth=1 https://github.com/xinax/laravel-gettext
git clone --depth=1 https://github.com/michaeldouglas/laravel-pagseguro
git clone --depth=1 https://github.com/irazasyed/laravel-gamp

[ -d $tdir/mail ] || mkdir -p $tdir/mail
cd $tdir/mail
git clone --depth=1 https://github.com/themsaid/laravel-mail-preview
git clone --depth=1 https://github.com/fedeisas/laravel-mail-css-inliner
git clone --depth=1 https://github.com/Bogardo/Mailgun
