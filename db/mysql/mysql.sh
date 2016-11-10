#!/bin/sh
. ./include/help.sh
#SET PASSWORD FOR admin=PASSWORD('123456');
# http://www.mamicode.com/info-detail-1202395.html

init(){
# firstly backup 
  mysqldump -S /tmp/mysql.sock -A -p --set-gtid-purged=OFF > backup_20161108.sql 
# init database with no user info
  /usr/local/mysql/bin/mysqld --defaults-file=/etc/my.cnf  --initialize-insecure
# start mysqld so that we can recovery data
  [ -d /usr/local/mysql/var ] && mv /usr/local/mysql/var /usr/local/mysql/var.bak && mkdir -p /usr/local/mysql/var && chown -R mysql:mysql /usr/local/mysql/var
  [ -d /var/log/mysql ] && mv /var/log/mysql /var/log/mysql.bak && mkdir -p /var/log/mysql && chown -R mysql:mysql /var/log/mysql
  /etc/init.d/mysql restart
# import data backup from 1st step
  /usr/local/mysql/bin/mysql -S /tmp/mysql.sock -p  <    backup_20161108.sq

#update mysql.user set authentication_string=password('go3c86985773') where user='root' ; 

/usr/local/mysql/bin/mysqld_safe --defaults-file=/etc/my.cnf --skip-grant-tables &
/usr/local/mysql/bin/mysql_upgrade --defaults-file=/etc/my.cnf -p --force && /etc/init.d/mysql restart


}





db(){
  echo "nothing"
}

HOSTNAME="127.0.0.1"
uSERNAME="root"
PASSWORD="go3c86985773"
PORT="3306"
MYSQL="mysql -h ${HOSTNAME} -P ${PORT} -u root -p${PASSWORD} -e"
MYSQL1="mysql -h ${HOSTNAME} -P ${PORT} -u root -p -e"
new_db()
{
   local dbname=$1
   local opstr="create database IF NOT EXISTS ${dbname}"
   echo "$MYSQL $opstr"
   $MYSQL "$opstr"   
}

upgrade(){
   /etc/init.d/mysqld stop
   /usr/local/mysql/bin/mysqld_safe --defaults-file=/etc/my.cnf --skip-grant-tables &
   /usr/local/mysql/bin/mysql_upgrade --defaults-file=/etc/my.cnf -p --force && \
   /etc/init.d/mysqld restart
   
}

reset(){
   local passwd=$1
   sudo /etc/init.d/mysqld stop
   sudo /usr/local/mysql/bin/mysqld_safe --defaults-file=/etc/my.cnf --skip-grant-tables &
    $MYSQL1  "update mysql.user set authentication_string=password('$passwd') where user='root' ; FLUSH PRIVILEGES;"
   sudo /etc/init.d/mysqld restart 
}


case $1 in
reset)param_check $# 2 "reset 'passwd'"
      [ "$?" == "1" ] && exit 1 
      reset $2;;
init)init;;
db) [ $# -lt 2 ] && {
      echo "$0 [db] [dbname]"
      exit 1
    }
    DBNAME=$2
    create_db_sql="create database IF NOT EXISTS ${DBNAME}"
    mysql -h ${HOSTNAME} -P ${PORT} -u root -p${PASSWORD} -e "${create_db_sql}" ;;
new)new_db test;;
  *)help "[reset|init] [passwd]";;
esac
