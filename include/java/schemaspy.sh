#!/bin/sh





src_install(){
   pushd /home/build || exit 1
   [ -f /home/build/pkg/schemaspy-master.zip ] || {
        wget https://github.com/drnoa/schemaspy/archive/master.zip -O /home/build/pkg/schemaspy-master.zip || exit 1
   }
}


src_build(){
    [ -d /home/build/schemaspy ] || {
         unzip -x /home/build/pkg/schemaspy-master.zip -d /home/build/ || exit 1
   }
    pushd /home/build/schemasp || exit 1
}


