#!/bin/sh

install(){
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === 'aa96f26c2b67226a324c27919f1eb05f21c248b987e6195cad9690d5c1ff713d53020a02ac8c217dbf90a7eacc9d141d') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php --install-dir=/usr/bin --filename=composer  --version=1.2.2
php -r "unlink('composer-setup.php');"
}

curl_install(){
	curl -sS https://getcomposer.org/installer | php    
        mv composer.phar /usr/local/bin/composer
}

check(){
    which composer || exit 1
    composer -V
}

config(){

    composer config -g repo.packagist composer https://packagist.phpcomposer.com 
}

case $1 in 
   install)install;;
   check)check;;
   curl) curl_install;;
   config)config;;
esac
