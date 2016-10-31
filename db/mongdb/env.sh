#!/bin/sh

gen_repo(){

[ -f /etc/yum.repos.d/mongodb-org-3.4.repo ] || {
echo '
[mongodb-org-3.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/testing/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc' > /etc/yum.repos.d/mongodb-org-3.4.repo
}
}

install(){

yum install -y mongodb-org

}


remove()
{
	service mongod stop
        sudo yum erase $(rpm -qa | grep mongodb-org)
        rm -r /var/log/mongodb
        rm -r /var/lib/mongo
}

start()
{
   echo "start here"
 
}

help ()
{
 echo "$0 [repo|install|remove]"
}


case $1 in

repo) gen_repo;;
install) install ;;
remove) ;;
start) ;;
*) help;;

esac
