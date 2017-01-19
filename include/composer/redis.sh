#!/bin/sh

nrk_predis(){
   print_color "https://github.com/nrk/predis"
   local wdir=$1
   pushd $wdir || exit 1
   require_insert  $wdir "predis/predis" "1.1.*@dev"
   [ -f ./composer.json ] && {
      composer update
   }
}

echo "Composer package:"
echo "	nrk_predis: php redis"
