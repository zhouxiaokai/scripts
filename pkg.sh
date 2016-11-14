#!/bin/sh

. ./include/help.sh
. ./include/jquery.sh


[ $# -lt 2 ] && {

 echo "$0 [pkgname ] [dir]"
 exit 1
}

pkgs="jquery datatables iCheck ionicons bootstrap font_awesome admin_lte select2"

case $1 in
 jquery) shift 1
         param_check $# 3 "tdir ver rel"
         [ $? -ne 0 ] && exit 1
          jquery $@;;
 datatable)
         shift 1
         param_check $# 3 "tdir ver rel"
         [ $? -ne 0 ] && exit 1
         datatables $@ ;;
 bootstrap) shift 1
            bootstrap $@;;
  all)  for pkg in $pkgs
      do
           echo "$pkg $2"
           $pkg $2
      done;;
esac
