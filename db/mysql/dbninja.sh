#!/bin/sh


tdir=$2

help(){
 echo "$0 [target dir]"
 exit 1
}


install(){
[ -d $tdir/dbninja ] || {
   wget http://dbninja.com/download/dbninja.tar.gz -O /tmp/dbninja.tar.gz || {
         echo "Downloading from http://dbninja.com/download/dbninja.tar.gz failed"
         exit 1
   }
   tar -xzvf /tmp/dbninja.tar.gz -C $tdir
   sudo chmod 775 $tdir/dbninja/_users
}
#http://www.dbninja.com/?page=resources&z=102
   sudo yum -y install  php-mysqli
   sudo yum -y --enablerepo=remi install php-pecl-jsonc
   user=` ps -eo ruser,rgroup,command |egrep "apache|nginx|lighttpd" |egrep -m 1 -v "root|grep" | awk '{print $1}'`
   group=` ps -eo ruser,rgroup,command |egrep "apache|nginx|lighttpd" |egrep -m 1 -v "root|grep" | awk '{print $2}'`
   sudo chown -R $user:$group $tdir/dbninja 

}

test(){
	ps -eo ruser,rgroup,command |egrep "apache|nginx|lighttpd" |egrep -m 1 -v "root|grep"
}

case $1 in
   install) 

	[ -d "$tdir" ] || help
             install;;
   test)test ;;
   *) help ;;
esac


