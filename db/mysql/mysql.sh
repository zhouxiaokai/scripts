#!/bin/sh

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

HOSTNAME="127.0.0.1"                                    #数据库信息
PORT="3306"
USERNAME="root"
PASSWORD="go3c86985773"
DBNAME=""；                                              #数据库名称
TABLENAME=""；  

new_db(){
  echo "nothing"
}

case $1 in
init)init;;
db) [ $# -lt 2 ] && {
      echo "$0 [db] [dbname]"
      exit 1
    }
    DBNAME=$2
    create_db_sql="create database IF NOT EXISTS ${DBNAME}"
    mysql -h ${HOSTNAME} -P ${PORT} -u root -p${PASSWORD} -e "${create_db_sql}" ;;
esac
