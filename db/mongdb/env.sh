#!/bin/sh

[ -f /etc/yum.repos.d/mongodb-org-3.4.repo ] || {
echo '
[mongodb-org-3.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/testing/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc' > /etc/yum.repos.d/mongodb-org-3.4.repo

yum install -y mongodb-org
