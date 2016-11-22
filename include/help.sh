#!/bin/sh

param_check()
{
 [ "$1" -lt $2 ] &&  {
  echo "$0 $3"
  return 1
 }
  return 0
}


help(){
  echo "$0 $1"
  exit 1
}

getowner(){

echo `getfacl $1 2>/dev/null | grep owner | awk '{print $3 }'`

}

getgroup(){
 echo `getfacl $1 2>/dev/null | grep group | awk '{print $3 }'`
}

setdir(){
  local wdir=$1
  local sdir=$2
  [ -z "$sdir" ] || {
      [ -d $wdir ] || return 1
  }
  [ -d $wdir/$sdir ] ||  mkdir -p $wdir/$sdir || exit 1
  return 0
}

get_php_ver(){
  echo `php -v  | awk  "NR==1{ print $2}" | awk -F' ' '{print $2}'`

}

#http://blog.chinaunix.net/uid-26495963-id-3189345.html
print_color(){
  echo -e "\033[1m  $1 \033[0m" 
}
