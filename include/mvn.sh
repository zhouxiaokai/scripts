#!/bin/sh

mvn_install()
{
   local ver="3.3.9"
   local url="http://mirrors.cnnic.cn/"
   local pkg="apache/maven/maven-3/$ver/binaries/apache-maven-$ver-bin.tar.gz"
   local tdir="/usr/local"
   pkg_tgz_i $pkg $tdir $url 
}


