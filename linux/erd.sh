#!/bin/sh


install_erd_from_src(){
	pushd /home/build/erd || {
		git clone git://github.com/BurntSushi/erd || exit 1
	}
	pushd /home/build/erd || exit 1
	cabal configure 
	cabal build
}

install_erd_fromcbal(){
	
}

install(){
   cabal --help || {
	./linux/haskell.sh install || exit 1
	}
   cabal update
   cabal install erd
}

$@
