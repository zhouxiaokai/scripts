#!/bin/sh

. ./include/download.sh
. ./include/mvn.sh

wdir=$1
[ -z "$wdir" ] && {
 echo "$0 [workdir]"
 exit 1
}
[ -d $wdir ] || mkdir -p $wdir
cdir=`pwd`
echo "wdir=$wdir"
echo $wdir | grep "^[.]" && wdir=`pwd`/$wdir
echo "wdir=$wdir"
which nrm || sudo npm -g i nrm
sudo nrm use taobao

which nrm || sudo npm -g i nrm
sudo nrm use taobao

ver="2.10.4"
[ -d $wdir/swagger-editor-$ver ] || {
   pkg="swagger-api/swagger-editor/archive/v$ver/master.zip"
   tpkg="swagger-editor-$ver.zip"
 #git clone --depth=1  -b v2.10.4 https://github.com/swagger-api/swagger-editor/
 download_zip_x $pkg  $tpkg $wdir
 
 [ $? -ne 0 ] && exit 1  
 sed -i "s/.*var.*IP.*=.*/var IP = 'www.go3c.tv';/g" $wdir/swagger-editor-$ver/server.js
 cd $wdir/swagger-editor-$ver
 [ -d ./node_modules ] ||  sudo npm install
 [ -d ./dist ] ||  npm run  build
  
  sudo netstat -lt | grep 8010 || PORT=8010  npm start   --production
  cd $cdir
}

  ver="2.2.6"


[ -d $wdir/swagger-ui-$ver ] || { 
  pkg="swagger-api/swagger-ui/archive/v$ver/master.zip"
  tpkg="swagger-ui-$ver.zip"  
  download_zip_x $pkg  $tpkg $wdir
  [ $? -ne 0 ] && exit 1  
  cd $wdir/swagger-ui-$ver
  npm i
  npm run build
 }
 
  sed -i '/.*window.swaggerUi.*SwaggerUi({/a \       validatorUrl: undefined,' $wdir/swagger-ui-$ver/dist/index.html
  sed -i 's|^.*lang/translator.js.*$|	<script src='lang/translator.js' type='text/javascript'></script>|g' $wdir/swagger-ui-$ver/dist/index.html
  sed -i 's|^.*lang/en.js.*$|	<script src='lang/zh-cn.js' type='text/javascript'></script>|g' $wdir/swagger-ui-$ver/dist/index.html


swagger_codegen(){
  local ver="2.2.1"
  local  pkg="swagger-api/swagger-codegen/archive/v$ver/master.zip"
  local tpkg="swagger-codegen-$ver.zip"
  local mver="3.3.9"
  export PATH=$PATH:/usr/local/apache-maven-$mver/bin
  [ -f /usr/local/apache-maven-$mver/bin/mvn ] || mvn_install $mver
  export JAVA_HOME="/usr/local/java/jdk1.7.0_80" && export PATH=$PATH:/usr/local/apache-maven-$mver/bin:$JAVA_HOME/bin && mvn --version
  export JAVA_HOME="/usr/local/java/jdk1.7.0_80" && export PATH=$PATH:/usr/local/apache-maven-3.3.9/bin:$JAVA_HOME/bin && mvn --version
  [ -d $wdir/swagger-codegen-$ver ] || download_zip_x $pkg  $tpkg $wdir
   sed -i 's|*.https:.*/master.tar.gz| <url>http://www.go3c.tv:8040/download/devel/app/swagger-api/swagger-ui/archive/master.tar.gz</url> |g'  $wdir/swagger-codegen-$ver/modules/swagger-generator/pom.xml
   cd $wdir/swagger-codegen-$ver  &&  mvn clean package    
}

swagger_codegen  
