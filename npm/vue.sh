#!/bin/sh

clone(){
  git clone --depth=1 https://github.com/matfish2/vue-tables
  git clone --depth=1 https://github.com/ihanyang/Absolute-Grid
  git clone --depth=1 https://github.com/jbaysolutions/vue-grid-layout 
  git clone --depth=1 https://github.com/STRML/react-grid-layout

}

config(){
  cd vue-tables && npm i && bower i
  cd Absolute-Grid && npm i && bower i
  cd vue-grid-layout && npm i
  cd react-grid-layout && npm i
}

case $1 in 
   clone )clone;;
   config)config;;
esac
