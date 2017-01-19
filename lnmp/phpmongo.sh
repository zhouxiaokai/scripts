#!/bin/sh

WDIR=/home/build
#VER=1.6.14
#URL="https://github.com/mongodb/mongo-php-driver-legacy/archive"
#DIR=mongo-php-driver-legacy-$VER
VER=1.2.2
DIR=mongo-php-driver

leagcy(){
    [ -f $WDIR/pkg/phpmongodb-$VER.zip ] || {
        wget -r  $URL/$VER.zip -O $WDIR/pkg/phpmongodb-$VER.zip || {
                echo "Download $URL/$VER.zip failed"
                exit 1
        }
   }
   pushd $WDIR
   unzip -x  $WDIR/pkg/phpmongodb-$VER.zip
}

driver(){
    git clone https://github.com/mongodb/mongo-php-driver.git
    cd ./mongo-php-driver
    git submodule sync && git submodule update --init
}

[ -d $WDIR/pkg ] || mkdir -p $WDIR/pkg
[ -d $WDIR/$DIR ] || {
 driver  
}



pushd $WDIR/$DIR || exit 1
sudo yum -y install libgsasl-devel.x86_64 libgsasl.x86_64 cyrus-sasl-gssapi.x86_64 cyrus-sasl-ldap.x86_64 cyrus-sasl-devel.x86_64
export CFLAGS="-Wall -Wextra -Wdeclaration-after-statement -Wmissing-field-initializers -Wshadow -Wno-unused-parameter -ggdb3"
/usr/local/php/bin/phpize

./configure  --with-php-config=/usr/local/php/bin/php-config  --with-mongo-sasl || exit 1
make  || exit 1
sudo make install || exit 1
echo "extension=mongodb.so" > ./ext-mongodb.ini
sudo cp ./ext-mongodb.ini /usr/local/php/etc/php.d/ext-mongodb.ini
popd

