#!/bin/sh

. ./include/download.sh

mvn_install()
{
   local ver="3.3.9"
   local url="http://mirrors.cnnic.cn/"
   local pkg="apache/maven/maven-3/$ver/binaries/apache-maven-$ver-bin.tar.gz"
   local tdir="/usr/local"
   pkg_tgz_i $pkg $tdir $url 
}

java_mysql(){
	echo ""
	local DPKG=/home/build/pkg
        local PKG=mysql57-community-release-el6-9.noarch.rpm
        [ -f $DPKG/$PKG ] || {
		wget -c  https://dev.mysql.com/get/$PKG -O $DPKG/$PKG || exit 1
	}
       sudo rpm -ivh $DPKG/$PKG || exit 1
       sudo yum -y install mysql-connector-odbc.x86_64
       sudo yum -y install mysql-connector-java.noarch 
}

java_mysql_src(){
  	echo "http://dev.mysql.com/doc/connector-odbc/en/connector-odbc-installation-source-unix.html"
}
mvn_install
