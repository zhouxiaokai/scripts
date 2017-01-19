#!/bin/sh

install(){
   sudo yum install -y haskell-platform
   sudo cabal install cabal-install
   yum -y install graphviz.x86_64 graphviz-python.x86_64 graphviz-devel.x86_64

}

$@
