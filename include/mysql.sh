#!/bin/sh

# fixed Host '127.0.0.1' is not allowed to connect to this MySQL server
# see http://blog.csdn.net/liuyan4794/article/details/8526407 for detail
localhost_enable(){

grep "^skip-name-resolve" /etc/my.cnf && sed -i 's|skip-name-resolve|#skip-name-resolve|g' /etc/my.cnf

}

java_connector(){
	echo "http://dev.mysql.com/doc/mysql-yum-repo-quick-guide/en/#legalnotice"
	local TDIR=/home/build/pkg/
	local PKG=mysql-connector-java-5.1.40.tar.gz
	[ -f /usr/share/mysql-connector-java.jar ] && return 0

	[ -d /home/build/pkg/ ] || {
		wget -c http://dev.mysql.com/get/Downloads/Connector-J/$PKG -O $TDIR/$PKG
	}
	pushd /home/build/mysql-connector-java-5.1.40 || {
		tar -xzvf $TDIR/$PKG -C /home/build
	}
	pushd /home/build/mysql-connector-java-5.1.40 || exit 1
	sudo cp /home/build/mysql-connector-java-5.1.40/mysql-connector-java-5.1.40-bin.jar /usr/share/java/
	sudo ln -sf mysql-connector-java-5.1.40-bin.jar /usr/share/java/mysql-connector-java.jar	
}

utilities(){

	local TDIR=/home/build/pkg/
        local PKG=mysql-utilities-1.6.4-1.el6.noarch.rpm

        [ -d /home/build/pkg/ ] || {
                wget -c http://dev.mysql.com/get/Downloads/MySQLGUITools/$PKG -O $TDIR/$PKG
        }
        sudo rpm -Uvh $TDIR/$PKG
	echo "http://dev.mysql.com/doc/mysql-utilities/en/" 
}

echo "MySQL Install:"
echo "	utilities:  assist in maintaining and administering MySQL servers"
echo "	java_connector:Standardized database driver for Java platforms and developmen"
