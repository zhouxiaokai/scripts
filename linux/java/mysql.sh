#!/bin/sh

java_connector(){
        local TDIR=/home/build/pkg/
        local PKG=mysql-connector-java-5.1.40.tar.gz
        [ -f /usr/share/mysql-connector-java.jar ] && return 0

        [ -d $TDIR/$PKG ] || {
                wget -c http://dev.mysql.com/get/Downloads/Connector-J/$PKG -O $TDIR/$PKG
        }
        pushd /home/build/mysql-connector-java-5.1.40 || {
                tar -xzvf $TDIR/$PKG -C /home/build
        }
        pushd /home/build/mysql-connector-java-5.1.40 || exit 1
        sudo cp /home/build/mysql-connector-java-5.1.40/mysql-connector-java-5.1.40-bin.jar /usr/share/java/
        sudo ln -sf mysql-connector-java-5.1.40-bin.jar /usr/share/java/mysql-connector-java.jar
}


echo "MySQL Install:"
echo "  java_connector:Standardized database driver for Java platforms and developmen"

$@
