#!/bin/sh

arch=`uname -p` #X86_64
os=`uname -s`   #Linux
rel=`cat /etc/redhat-release  | awk '{print $1}'`  #CentOS
rev=`cat /etc/redhat-release  | awk '{print $4}'`  #Version
[ "$rev" == "(Final)" ] && rev=`cat /etc/redhat-release  | awk '{print $3}'`
check_platform()
{
  echo "$arch $os $rel $rev"
}
check_erlang()
{
  which erl || {
    echo "no erlang found, "
    exit 1
  }   
}

rpm_install(){
  case $rev in 
    6*) pkg=erlang-19.0.4-1.el6.$arch.rpm;;
    7*) pkg=erlang-19.0.4-1.el7.$arch.rpm;;
  esac
   wget -c  http://www.rabbitmq.com/releases/erlang/$pkg -O /tmp/erlang.rpm || exit 1
   sudo rpm -ivh /tmp/erlang.rpm
}

src_install(){
   pkg="otp_src_R16B03.tar.gz"
   wget -c http://www.erlang.org/download/$pkg -O /tmp/$pkg || exit 1
   tar -xzvf /tmp/$pkg -C /tmp/
   cd /tmp/otp_src_R16B03 && ./configure && make install 
}

yum_install(){
    wget -c https://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm -O /tmp/erlang-solutions-1.0-1.noarch.rpm
   sudo rpm -Uvh /tmp/erlang-solutions-1.0-1.noarch.rpm
   sudo yum --disablerepo=epel install erlang #|| yum install esl-erlang
}

case $1 in 
  env) check_platform
       check_erlang
       exit 0;;
  rpm) rpm_install;;  
  src) src_install;;
  yum) yum_install;;
esac
