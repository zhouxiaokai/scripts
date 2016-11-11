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
 local sdir=$1
[ -d $tdir/$sdir ] || sudo  mkdir -p $tdir/$sdir && cd $tdir/$sdir
echo "We are  $tdir/$sdir"
}

GIT="git clone --depth=1"

setdir generator/laravel

$GIT https://github.com/InfyOmLabs/adminlte-generator 
