#!/bin/sh
wdir=$1
[ -z "$wdir" ] && {
 echo "$0 [workdir]"
 exit 1
}

ver="2.10.4"
[ -d $wdir/swagger-editor ] || {
 #git clone --depth=1  -b v2.10.4 https://github.com/swagger-api/swagger-editor/
  [ -f /tmp/swagger-editor-$ver.zip ] || wget https://github.com/swagger-api/swagger-editor/archive/v$ver/master.zip -O /tmp/swagger-editor-$ver.zip
  [ -d $wdir/swagger-editor-$ver ] ||  unzip -x /tmp/swagger-editor-$ver.zip -d $wdir/
  cd $wdir/swagger-editor-$ver

 sed -i "s/.*var.*IP.*=.*/var IP = 'www.go3c.tv';/g" $wdir/swagger-editor-$ver/server.js
 sudo  npm install
 npm build
 PORT=8010 sudo npm start
}

  ver="2.2.6"
[ -d $wdir/swagger-ui-$ver ] || { 
 #git clone --depth=1  -b v$ver https://github.com/swagger-api/swagger-ui
  [ -f /tmp/swagger-ui-$ver.zip ] || wget https://github.com/swagger-api/swagger-ui/archive/v$ver/master.zip -O /tmp/swagger-ui-$ver.zip
  [ -d /tmp/swagger-ui-$ver ] || unzip -x /tmp/swagger-ui-$ver.zip -d $wdir/
  cd $wdir/swagger-ui-$ver
  npm i
  npm run build
  
  sed -i '/.*window.swaggerUi.*SwaggerUi({/a \       validatorUrl: undefined,' $wdir/swagger-ui-$ver/dist/index.html
}
