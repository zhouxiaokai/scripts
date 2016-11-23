#!/bin/sh

php_src(){
  download_env_src /home/build/ php-$(get_php_ver).tar.gz
}

php_upgrade(){
  local wdir=$1
  [ -z "$wdir" ] && wdir="/home/build/"
  [ -d $wdir/oneinstack ] || {
     [ -f $wdir/oneinstack-full.tar.gz ] || download_env_src $wdir oneinstack-full.tar.gz
     pushd $wdir
  } 
  pushd oneinstack
  sudo ./upgrade.sh php 
}

php_ext_fileinfo(){
  echo "Download"
    
  [ -d /home/build/php-$(get_php_ver) ] ||  download_env_src /home/build/ php-$(get_php_ver).tar.gz
  pushd /home/build/php-$(get_php_ver)/ext/fileinfo
  ${php_install_dir}/bin/phpize
  ./configure --with-php-config=${php_install_dir}/bin/php-config
   make -j ${THREAD} && make test && make install
   echo "extension=fileinfo.so" > ${php_install_dir}/etc/php.d/ext-fileinfo.ini
   php -i | grep gmp | grep enabled && return 0
   return 1

}

php_ext_gmp(){
  yum -y install gmp.x86_64 gmp-devel.x86_64 
  [ -d /home/build/php-$(get_php_ver) ] ||  download_env_src /home/build/ php-$(get_php_ver).tar.gz
  pushd /home/build/php-$(get_php_ver)/ext/gmp
  ${php_install_dir}/bin/phpize 
  ./configure --with-php-config=${php_install_dir}/bin/php-config
   make -j ${THREAD} && make test && make install
   echo "extension=gmp.so" > ${php_install_dir}/etc/php.d/ext-gmp.ini
   php -i | grep gmp | grep enabled && return 0
   return 1 
}
