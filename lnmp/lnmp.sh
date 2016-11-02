#!/bin/sh

src_install()
{
  pkg="lnmp1.3-full.tar.gz"
  url="ftp://soft3.vpser.net/lnmp"
  wget -c $url/$pkg && tar zxf $pkg && cd $pkg && ./install.sh lnmp
}

screen_install(){
 which screen || sudo yum -y install screen
 screen -S lnmp
}


case $1 in
   src)src_install;;
   screen)screen_install;;
esac
