#!/bin/sh

rpm_install(){
   pkg="rabbitmq-server-3.6.5-1.noarch.rpm"
   wget -c http://www.rabbitmq.com/releases/rabbitmq-server/v3.6.5/$pkg -O /tmp/$pkg
}
yum_install(){
   rpm --import https://www.rabbitmq.com/rabbitmq-release-signing-key.asc
   yum --disablerepo=epel  install /tmp/rabbitmq-server-3.6.5-1.noarch.rpm
}

case $1 in
     yum) rpm_install
          yum_install;;
esac
