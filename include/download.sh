#!/bin/sh


urls="http://www.go3c.tv:8040/download/devel/app/     http://www.go3c.tv:8040/download/devel/env       https://github.com/"


download_zip_x()
{
  local spkg=$1
  local tpkg=$2
  local tdir=$3

  for url in $urls
  do 
       wget $url/$spkg -O /tmp/$tpkg && break 
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
       wget $url/$spkg -O /tmp/tmp.tgz  && break
  done
  sudo tar -xzvf /tmp/tmp.tgz -C $tdir
  rm -rf /tmp/tmp.tgz
}


download_git(){
 local gurl="https://github.com"
 local tdir=$1
 local pkg=$2
 local ver=$3
 [ -z $ver ] || local br="-b $3"
 #try git firstly
 cd $tdir  || exit 1
 print_color "$gurl/$pkg $br"
 #git clone --depth=1 $br $gurl/$pkg  && return 0
 #try download master.zip
 [ -d /tmp/$pkg ] || mkdir -p /tmp/$pkg 
 local pkgs="$ver.zip v$ver.zip"
 for url in $urls
 do
     for i in $pkgs
     do 
      print_color $url/$pkg/archive/$ver.zip
      wget $url/$pkg/archive/$ver.zip -O /tmp/$pkg/master.zip || continue
      unzip -x /tmp/$pkg/master.zip  &&  return 0
     done
 done
 return 0
}
