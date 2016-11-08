#!/bin/sh

BACKFLAGS=" -e --max_allowed_packet=4194304 --net_buffer_length=16384 "
go3c(){
  mysqldump -u root -p --databases  > D:\backup.sql
  mysqldump -u root  -p --all-databases > go3c-`date '+%Y-%m-%d-%H-%M-%S'`.sql
}

all(){
  local   tdir=$1

  [ -d $tdir ] || {
   echo "Target directory $tdir not exist"
   exit 1
 }
  echo "mysqldump -u root  -p --all-databases > $tdir/`hostname`-`date '+%Y-%m-%d-%H-%M-%S'`.sql"
  mysqldump -u root  -p --all-databases $BACKFLAGS > $tdir/`hostname`-`date '+%Y-%m-%d-%H-%M-%S'`.sql
}

help_back(){
  echo "$0 [all|db] [target dir]"
}

[ $# -lt 2 ] && help_back
case $1 in
   all) all $2;;
    *) help_back;;
esac
