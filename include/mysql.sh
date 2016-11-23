#!/bin/sh

# fixed Host '127.0.0.1' is not allowed to connect to this MySQL server
# see http://blog.csdn.net/liuyan4794/article/details/8526407 for detail
localhost_enable(){

grep "^skip-name-resolve" /etc/my.cnf && sed -i 's|skip-name-resolve|#skip-name-resolve|g' /etc/my.cnf

}


