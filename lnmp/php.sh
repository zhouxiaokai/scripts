#!/bin/sh

backup_php()
{
  which php || return
  phpb=`which php`
  phpv=`php -v | awk 'NR==1{print $2}'`
  case $phpv in
     7.*|5.6) echo "php version is latest enough" exit 1;;
     *)   mv $phpb  `dirname $phpb`/php.$phpv
          mv /usr/local/php/etc/php.ini /usr/local/php/etc/php.ini.$phpv;;
  esac

}

php_ini(){

phpini=$1
[ -z "$phpini" ] && phpini=/usr/local/php/etc/php.ini

sed -i 's@^output_buffering =@output_buffering = On\noutput_buffering =@' $phpini                   
sed -i 's@^;cgi.fix_pathinfo.*@cgi.fix_pathinfo=0@' $phpini                   
sed -i 's@^short_open_tag = Off@short_open_tag = On@' $phpini                   
sed -i 's@^expose_php = On@expose_php = Off@' $phpini                   
sed -i 's@^request_order.*@request_order = "CGP"@' $phpini                   
sed -i 's@^;date.timezone.*@date.timezone = Asia/Shanghai@' $phpini                   
sed -i 's@^post_max_size.*@post_max_size = 50M@' $phpini                   
sed -i 's@^upload_max_filesize.*@upload_max_filesize = 50M@' $phpini                   
sed -i 's@^;upload_tmp_dir.*@upload_tmp_dir = /tmp@' $phpini                   
sed -i 's@^max_execution_time.*@max_execution_time = 5@' $phpini                   
sed -i 's@^disable_functions.*@disable_functions = passthru,exec,system,chroot,chgrp,chown,shell_exec,proc_open,proc_get_status,ini_alter,ini_restore,dl,openlog,syslog,readlink,symlink,popepassthru,stream_socket_server,fsocket,popen@' $phpini                   
sed -i 's@^session.cookie_httponly.*@session.cookie_httponly = 1@' $phpini                   
sed -i 's@^mysqlnd.collect_memory_statistics.*@mysqlnd.collect_memory_statistics = On@' $phpini                   

}

php_opcache()
{
phpini=$1
[ -z "$phpini" ] && phpini=/usr/local/php/etc/php.ini

sed -i 's@^opcache@[opcache]\nzend_extension=opcache.so@' $phpini 
sed -i 's@^;opcache.enable=.*@opcache.enable=1@' $phpini  
sed -i  's@^;opcache.memory_consumption.*@opcache.memory_consumption=128@' $phpini 
sed -i 's@^;opcache.interned_strings_buffer.*@opcache.interned_strings_buffer=8@' $phpini  
sed -i 's@^;opcache.max_accelerated_files.*@opcache.max_accelerated_files=4000@' $phpini 
sed -i 's@^;opcache.revalidate_freq.*@opcache.revalidate_freq=60@' $phpini  
sed -i 's@^;opcache.save_comments.*@opcache.save_comments=0@' $phpini 
sed -i 's@^;opcache.fast_shutdown.*@opcache.fast_shutdown=1@' $phpini 
sed -i 's@^;opcache.enable_cli.*@opcache.enable_cli=1@' $phpini 
sed -i 's@^;opcache.optimization_level.*@;opcache.optimization_level=0@' $phpini 

}

php_fpm(){

echo '
[global]  
pid = /usr/local/php/var/run/php-fpm.pid  
error_log = /usr/local/php/var/log/php-fpm.log  
log_level = notice  
  
  
[www]  
listen = /tmp/php-cgi.sock  
listen.backlog = -1  
listen.allowed_clients = 127.0.0.1  
listen.owner = www  
listen.group = www  
listen.mode = 0666  
user = www  
group = www  
pm = dynamic  
pm.max_children = 20 
pm.start_servers = 10
pm.min_spare_servers = 10  
pm.max_spare_servers = 20  
request_terminate_timeout = 100  
request_slowlog_timeout = 0  
slowlog = var/log/slow.log  
' >/usr/local/php/etc/php-fpm.conf

}

src_install(){
   echo hello
   [ -d /tmp/php-5.6.22 ] || {
      wget -c  http://www.php.net/distributions/php-5.6.22.tar.gz -O /tmp/php-5.6.22.tar.gz || exit 1
      tar -xzvf /tmp/php-5.6.22.tar.gz -C /tmp || exit 1
   }

    cd /tmp/php-5.6.22 && [ -f Makefile ] || ./configure \
                   --prefix=/usr/local/php \
                   --with-config-file-path=/usr/local/php/etc \
                   --with-fpm-user=www \
                   --with-fpm-group=www  \
                   --enable-fpm --enable-opcache \
                   --with-mysql=mysqlnd \
                   --with-mysqli=mysqlnd \
                   --with-pdo-mysql=mysqlnd \
                   --enable-fileinfo   \
                   --with-iconv-dir=/usr/local  --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml   --disable-rpath --enable-bcmath --enable-shmop --enable-exif --enable-sysvsem --enable-inline-optimization --with-curl   --enable-mbregex --enable-mbstring  --with-mcrypt --with-gd --enable-gd-native-ttf --with-openssl --with-mhash  --enable-pcntl --enable-sockets --with-xmlrpc --enable-ftp --with-gettext --enable-zip --enable-soap --disable-ipv6  --disable-debug  
 
    cd /tmp/php-5.6.22 && [ -f Makefile ] &&  make ZEND_EXTRA_LIBS='-liconv' && sudo make install && {
          [ -L /usr/bin/php ] && rm -rf /usr/bin/php
          [ -f /usr/bin/php ] && rm -rf /usr/bin/php
          ln -sf /usr/local/php/bin/php /usr/bin/php 
          [ -L /usr/bin/php-cgi -o -f /usr/bin/php-cgi ] && rm -rf /usr/bin/php-cgi
          ln -sf /usr/local/php/bin/php-cgi /usr/bin/php-cgi
		
          [ -L /usr/bin/php-config -o -f /usr/bin/php-config ] && rm -rf /usr/bin/php-config
          ln -sf /usr/local/php/bin/php-config /usr/bin/php-config

          [ -L /usr/bin/phar.phar -o -f /usr/bin/phar.phar ] && rm -rf /usr/bin/phar.phar
          ln -sf /usr/local/php/bin/phar.phar /usr/bin/phar.phar

          [ -L /usr/bin/phpize -o -f /usr/bin/phpize ] && rm -rf /usr/bin/phpize
          ln -sf /usr/local/php/bin/phpize /usr/bin/phpize

    }
}

php_test(){
phpini=$1
[ -z "$phpini" ] && phpini=/usr/local/php/etc/php.ini
sed -i 's@^disable_functions.*@;disable_functions = @' $phpini
    [ -d /tmp/php-5.6.22 ] && cd /tmp/php-5.6.22 && make test
sed -i 's@^disable_functions.*@disable_functions = passthru,exec,system,chroot,chgrp,chown,shell_exec,proc_open,proc_get_status,ini_alter,ini_restore,dl,openlog,syslog,readlink,symlink,popepassthru,stream_socket_server,fsocket,popen@' $phpini
}

deploy(){

chkconfig --add php-fpm   
chkconfig php-fpm on
service php-fpm start
}

env (){
  yum -y install opencryptoki-devel.x86_64  nettle-devel.x86_64  beecrypt-devel.x86_64  cryptopp-devel.x86_64 ecryptfs-utils-devel.x86_64 cryptsetup-luks-devel.x86_64 libgcrypt-devel.x86_64  libmcrypt-devel.x86_64  libscrypt-devel.x86_64  libtomcrypt-devel.x86_64 opencryptoki-devel.x86_64 nss-pkcs11-devel.x86_64
}

case $1 in
   env) env;;
   src) src_install;;
   bak) backup_php;;
   ini) php_ini $2
        php_opcache $2
        php_fpm;;
   test)php_test;;
   deploy)deploy;;
esac
