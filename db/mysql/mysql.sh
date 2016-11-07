#!/bin/sh

#SET PASSWORD FOR admin=PASSWORD('123456');


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

update mysql.user set authentication_string=password('go3c86985773') where user='root' ; 

/usr/local/mysql/bin/mysqld_safe --defaults-file=/etc/my.cnf --skip-grant-tables &
/usr/local/mysql/bin/mysql_upgrade --defaults-file=/etc/my.cnf -p --force && /etc/init.d/mysql restart


}


case $1 in
init)init;;
esac
