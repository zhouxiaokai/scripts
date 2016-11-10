#!/bin/sh

repo7(){
   curl --silent --location https://rpm.nodesource.com/setup_7.x | bash -
}
repo6(){
   curl --silent --location https://rpm.nodesource.com/setup_6.x | bash -
}

install()
{

  yum -y install nodejs npm --enablerepo=epel --disablerepo=nodesource
  #yum -y install nodejs
  yum install gcc-c++ make
  yum -y install node-gyp  --enablerepo=epel --disablerepo=nodesource
}

case $1 in
 repo6) repo6;;
 repo7) repo7;;
 install)install;;
 upgrade);;
esac

