#!/bin/sh

arch=`uname -p` #X86_64
os=`uname -s`   #Linux
rel=`cat /etc/redhat-release  | awk '{print $1}'`  #CentOS
rev=`cat /etc/redhat-release  | awk '{print $4}'`  #Version

which gem || {
 yum -y install ruby.$arch ruby-devel rubygems rpm-build
}

gem sources --remove http://rubygems.org/

gem sources -a https://ruby.taobao.org/

gem sources -l
