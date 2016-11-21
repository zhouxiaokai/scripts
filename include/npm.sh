#!/bin/sh

env_inotify(){
  local wdir=$1 
  [ -d $wdir/inotify-tools-3.14 ] ||  download_git $wdir rvoicilas/inotify-tools  3.14
  cd $wdir/inotify-tools-3.14 || exit 1
  ./autogen.sh
  ./configure --prefix=/usr/local
  make && sudo make install 
}

env_libnotify(){
  print_color "https://github.com/GNOME/libnotify"
  sudo yum -y install libnotify.x86_64
  sudo yum -y install gtk-doc.noarch
  sudo yum -y install gdk-pixbuf2-devel.x86_64 gdk-pixbuf2.x86_64 
  #sudo yum -y install gtk+.x86_64 
local wdir=$1
local ver="0.5.0"
  [ -d $wdir/libnotify-$ver ] ||  download_git $wdir GNOME/libnotify  $ver
  cd $wdir/libnotify-$ver || exit 1
  ./autogen.sh
  ./configure --prefix=/usr/local  --disable-tests
  make && sudo make install
}


