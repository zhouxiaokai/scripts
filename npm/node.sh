#!/bin/sh

repo(){
  curl --silent --location https://rpm.nodesource.com/setup_7.x | bash -
}

install()
{
  yum -y install nodejs npm --enablerepo=epel --disablerepo=nodesource
  #yum -y install nodejs
  yum install gcc-c++ make
  yum -y install node-gyp --disablerepo=nodesource
}

case $1 in
 repo) repo;;
 install)install;;
 upgrade);;
esac

