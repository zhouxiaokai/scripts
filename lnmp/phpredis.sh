#!/bin/sh

WDIR=/home/build
VER=2.2.8
[ -d $WDIR/pkg ] || mkdir -p $WDIR/pkg
[ -d $WDIR/phpredis-$VER ] || {
   [ -f $WDIR/pkg/phpredis-$VER.zip ] || {
	wget -r https://github.com/phpredis/phpredis/archive/$VER.zip -O $WDIR/pkg/phpredis-$VER.zip || {
   		echo "Download https://github.com/phpredis/phpredis/archive/$VER.zip failed"
   		exit 1
	}
   }
   pushd $WDIR
   unzip -x  $WDIR/pkg/phpredis-$VER.zip
   popd
}

pushd $WDIR/phpredis-$VER || exit 1
/usr/local/php/bin/phpize
./configure  --with-php-config=/usr/local/php/bin/php-config
make && sudo make install
echo "extension=redis.so" > ./ext-redis.ini
sudo cp ./ext-redis.ini /usr/local/php/etc/php.d/ext-redis.ini
popd

