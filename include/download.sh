#!/bin/sh


urls="http://www.go3c.tv:8040/download/devel/app/     http://www.go3c.tv:8040/download/devel/env       https://github.com/"


download_zip_x()
{
  local spkg=$1
  local tpkg=$2
  local tdir=$3

  for url in $urls
  do 
       wget -c $url/$spkg -O /tmp/$tpkg && break 
  done
     
  unzip -x  /tmp/$tpkg -d $tdir      
}



pkg_tgz_i(){

urls="http://www.go3c.tv:8040/download/devel/env/ "
  local spkg=$1
  local tdir=$2
  local url=$3
  [ -z "$url" ] || urls="$urls $url" 
  for url in $urls
  do
       wget -c $url/$spkg -O /tmp/tmp.tgz  && break
  done
  sudo tar -xzvf /tmp/tmp.tgz -C $tdir
  rm -rf /tmp/tmp.tgz
}


download_git(){
 local gurl="https://github.com"
 local tdir=$1
 local pkg=$2
 local ver=$3
 local TMP=$tdir/tmp
 [ -z $ver ] || local br="-b $3"
 #try git firstly
 cd $tdir  || exit 1
 print_color "$gurl/$pkg $br"
 #git clone --depth=1 $br $gurl/$pkg  && return 0
 #try download master.zip
 [ -d $TMP/$pkg ] || mkdir -p $TMP/$pkg 
 local pkgs="v$ver.zip $ver.zip"
 for url in $urls
 do
     for i in $pkgs
     do 
      print_color $url/$pkg/archive/$ver.zip
      wget -c  $url/$pkg/archive/$i -O $TMP/$pkg/master.zip || continue
      print_color "Installing package"
      unzip -x $TMP/$pkg/master.zip  >/dev/null && {
              print_color "Install ok"
              return 0
       } 
     done
 done
 return 0
}

download_env_bin(){
  local urls="http://www.go3c.tv:8040/download/devel/lnmp/bin"
  local tdir=$1
  local pkg=$2
  echo "`dirname $pkg`"
  [ -d /tmp/`dirname $pkg` ] || mkdir -p /tmp/`dirname $pkg`
  for url in $urls
  do
     wget -c $url/$pkg -O /tmp/$pkg && break
  done
  [ -d $tdir ] || exit 1
  sudo tar -xzvf /tmp/$pkg -C $tdir && return 0
  return 1
}


download_env_src(){
  local urls="http://www.go3c.tv:8040/download/devel/lnmp/src"
  local tdir=$1
  local pkg=$2
  echo "`dirname $pkg`"
  [ -d /tmp/`dirname $pkg` ] || mkdir -p /tmp/`dirname $pkg`
  for url in $urls
  do
     wget -c $url/$pkg -O /tmp/$pkg && break
  done
  [ -d $tdir ] || exit 1
  tar -xzvf /tmp/$pkg -C $tdir && return 0
  return 1
}

