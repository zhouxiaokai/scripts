#!/bin/sh


. ./include/download.sh
. ./include/mvn.sh


VER=master

src_install(){
   pushd /home/build || exit 1
   [ -f /home/build/pkg/schemaspy-master.zip ] || {
        wget https://github.com/drnoa/schemaspy/archive/$VER.zip -O /home/build/pkg/schemaspy-$VER.zip || exit 1
   }
}


src_build(){
   [ -f /usr/share/java/schemaspy-5.0.1-jar-with-dependencies.jar ]  && return 
   [ -d /home/build/schemaspy-$VER ] || {
         unzip -x /home/build/pkg/schemaspy-$VER.zip -d /home/build/ || exit 1
   }
    pushd /home/build/schemaspy-$VER || exit 1
    [ -f ./target/schemaspy-5.0.1.jar ] || {	
    	mvn clean package assembly:single || exit 1
    }
    sudo cp ./target/schemaspy-5.0.1.jar /usr/share/java
    sudo cp ./target/schemaspy-5.0.1-jar-with-dependencies.jar /usr/share/java/
    sudo ln -sf schemaspy-5.0.1-jar-with-dependencies.jar /usr/share/java/schemaSpy.jar
	
}

mver="3.3.9"
export PATH=$PATH:/usr/local/apache-maven-$mver/bin
[ -f /usr/local/apache-maven-$mver/bin/mvn ] || mvn_install $mver
export JAVA_HOME="/usr/local/java/jdk1.7.0_80" && export PATH=$PATH:/usr/local/apache-maven-$mver/bin:$JAVA_HOME/bin && mvn --version

src_install
src_build
