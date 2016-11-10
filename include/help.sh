#!/bin/sh

param_check()
{
  echo "num=$1 1=$2"
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
