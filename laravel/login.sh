#!/bin/sh

clone(){
  local tdir=$1
  [ -d $tdir ] || {
   echo "$tdir not exist"
   exit 1
  }
  cd $tdir
  git clone --depth=1 https://github.com/parin95/Laravel-Login
  cd $tdir/Laravel-Login
  composer config  repo.packagist composer https://packagist.phpcomposer.com
  #sed -i 's|^.*"laravel/framework":.*|            "laravel/framework": "5.2.*"|g' $tdir/Laravel-Login/composer.json
  composer update 
  composer install
  git clone --depth=1 https://github.com/adamwathan/eloquent-oauth
   
}

  [ $# -lt 2 ] && {
   echo "$0" [clone] [tdir]
   exit 1
  }

case $1 in
   clone)
         clone $2 ;;
esac
