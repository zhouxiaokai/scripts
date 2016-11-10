#!/bin/sh

#http://www.opensoce.com/5439.html

src_install()
{
  local tdir=$1
  [ -d $tdir ] || {
   echo "$tdir not exist"
   exit 1
  }
  pkg="lnmp1.3-full.tar.gz"
#  url="ftp://soft3.vpser.net/lnmp"
  url="http://www.go3c.tv:8040/download/devel/lnmp/"
  [ -f $tdir/$pkg ] || wget -c $url/$pkg -O $tdir/$pkg 
  [ -d $tdir/lnmp1.3-full ] || tar zxf $tdir/$pkg -C $tdir 
   cd $tdir/lnmp1.3-full && sed -i 's/soft.vpser.net/soft2.vpser.net/g' lnmp.conf \
   && ./install.sh lnmp
}

screen_install(){
 which screen || sudo yum -y install screen
 screen -S lnmp
}


case $1 in
   src)[ $# -lt 2 ] && {
         echo "$0 [src] [bdir]"
         exit 1
       }
       src_install $2;;
   screen)screen_install;;
esac
