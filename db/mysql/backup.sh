#!/bin/sh

TEST="1"
. ./include/help.sh
. ./include/date.sh
. ./include/network.sh

MYSQLDUMP="/usr/local/mysql/bin/mysqldump -S /tmp/mysql.sock -p"go3c86985773" --set-gtid-purged=OFF"

#BACKFLAGS=" -e --max_allowed_packet=4194304 --net_buffer_length=16384 "

check_dir(){
  [ -d $1 ] || { 
   echo 1 
   return
}
  local hostmac=$(getmac)
   [ -d $1/$hostmac/$2/$(getdate)/$(gettime) ] || mkdir -p  $1/$hostmac/$2/$(getdate)/$(gettime)
   echo $1/$hostmac/$2/$(getdate)/$(gettime)
}

backup_all(){
   
  local tdir=$(check_dir $1 all)
   [ "$tdir" == "1" ] && return 
   $MYSQLDUMP -A   >  $tdir/data.sql || rm -rf $tdir
}

backup_db(){
  local tdir=$(check_dir $1 $2)
   [ "$tdir" == "1" ] && return 
  local dbn=$2
  $MYSQLDUMP  --databases $dbn > $tdir/data.sql || rm -rf $tdir
}
case $1 in
    all) param_check $# 2 "all [workdir]"
        shift
        backup_all $@;;
    db)  param_check $# 3 "db [workdir] [dbname]"
       echo "hello"
       shift  
       backup_db $@;;
    *) help "[all|db] [workdir] [dbname]";;
esac
