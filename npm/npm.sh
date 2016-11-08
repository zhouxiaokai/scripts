#!/bin/sh

wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm    
wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
rpm -ivh epel-release-6-8.noarch.rpm
rpm -ivh remi-release-6.rpm
 npm config set registry https://registry.npm.taobao.org
npm install -g nrm --registry=https://registry.npm.taobao.org
nrm ls
npm install -g cnpm --registry=https://registry.npm.taobao.org
