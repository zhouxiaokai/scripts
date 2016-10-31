#!/bin/sh

#https://blog.remirepo.net/pages/Config-en 
arch=`uname -p` #X86_64
os=`uname -s`   #Linux 
rel=`cat /etc/redhat-release  | awk '{print $1}'`  #CentOS
rev=`cat /etc/redhat-release  | awk '{print $4}'`  #Version


epel()
{
 rev=$1
[ -f ./epel-release-latest-$rev.noarch.rpm ] ||
  wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-$rev.noarch.rpm
[ -f ./remi-release-$rev.rpm ] ||  
  wget https://rpms.remirepo.net/enterprise/remi-release-$rev.rpm
[ -f ./remi-release-$rev.rpm ] && rpm -Uvh remi-release-$rev.rpm && rm -rf ./remi-release-$rev.rpm
[ -f ./epel-release-latest-$rev.noarch.rpm ] && rpm -Uvh epel-release-latest-$rev.noarch.rpm && rm -rf ./epel-release-latest-$rev.noarch.rpm 

}

rhel(){
  which subscription-manager || {
       yum -y install subscription-manager.$arch
  }
  rev=$1
  case $rev in
       7*) epel 7
           subscription-manager repos --enable=rhel-7-server-optional-rpms;;
       6*) epel 6
           
           rhn-channel --add --channel=rhel-$(uname -i)-server-optional-6;;
       5*) epel 5;;
  esac

}

fedora()
{
   rev=$1
   case $rev in 
        25|24) dnf install https://rpms.remirepo.net/fedora/remi-release-$rev.rpm;;
        23|22) wget https://rpms.remirepo.net/fedora/remi-release-$rev.rpm
               dnf install remi-release-$rev.rpm
               ;;
        *)wget https://rpms.remirepo.net/fedora/remi-release-$rev.rpm
          yum install remi-release-$rev.rpm ;;
   esac
}

repo(){
   rel=$1
   rev=$2
   case $rel in 
       CentOS)rhel $rev;;
       Fedora)fedora $rev;;
   esac
}

help(){
  echo "$0 [repo]"
}
case $1 in

repo) repo $rel $rev;;
*)help;;
esac

