#!/bin/sh

asgardcms_new(){
   print_color "https://asgardcms.com/docs/v1/getting-started/installation"
   local wdir=$1
   local name=$2
   [ -z "$name" ] || name="asgardcms"
   pushd $wdir || exit 1
   [ -d ./asgardcms ] || {
	composer create-project asgardcms/platform=2.0.x-dev $name     
   }
   
}

dropzone_laravel_image_upload_new(){
   print_color "https://github.com/codingo-me/dropzone-laravel-image-upload"
   local wdir=$1
   local name=$2
   [ -z "$name" ] || name="dropzone-laravel-image-upload"
   pushd $wdir/dropzone-laravel-image-upload-master || {
   	download_git $wdir/ codingo-me/dropzone-laravel-image-upload master || exit 1
   }
   pushd $wdir/dropzone-laravel-image-upload-master || exit 1
   composer install || exit 1
   npm i || exit 1
   npm i gulp || exit 1
   npm i vueify-insert-css@^1.0.0
   npm i babel-runtime@^5.8.25
   npm i vue-hot-reload-api@^1.2.0
   gulp
}

composer config -g  repo.packagist composer https://packagist.phpcomposer.com
echo "Support project:"
echo "	asgardcms_new:A modular multilingual CMS built with Laravel 5"
echo "	dropzone_laravel_image_upload_new: drop zone sample"
