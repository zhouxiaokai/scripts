#!/bin/sh

VER=2.7.4
PPATH=/home/build/pkg/python/
BDIR=/home/build/Python-$VER


pip_update(){
   pip -V && return 0
   wget https://bootstrap.pypa.io/get-pip.py -O $PPATH/get-pip.py || exit 1
   sudo python $PPATH/get-pip.py 

}

python_update(){
     local VER=2.7.4
     local PKG=Python-$VER.tgz
     echo "http://www.cnblogs.com/saneri/p/5111273.html"
     python -V || {
      
        pushd $BDIR  || {
            [ -d $PPATH ] || mkdir -p $PPATH
	    [ -f $PPATH/Python-$VER.tgz ] ||  {
		 wget http://python.org/ftp/python/$VER/$PKG -O $PPATH/$PKG || exit 1
            }
	    tar -xzvf $PPATH/Python-$VER.tgz -C /home/build
	} 
        pushd  $BDIR  || exit 1
        ./configure --prefix=/usr/local/python2.7
        make 
        sudo make install
    }
    [ -f  /usr/bin/python ] && {
        sudo mv /usr/bin/python /usr/bin/python.bak   
        sudo ln -s /usr/local/python2.7/bin/python2.7 /usr/bin/python
    }
    sudo sed -i 's|/usr/bin/python|python2.6|g' /usr/bin/yum
}

eralchemy_install(){
   python_update
   pip_update
   sudo yum -y install graphviz.x86_64 graphviz-python.x86_64 graphviz-devel.x86_64
   sudo  pip install pymysql
   pip install eralchemy
   export PATH=$PATH:/usr/local/python2.7/bin/
   [ -L /usr/bin/eralchemy ] || {
	sudo ln -sf /usr/local/python2.7/bin/eralchemy  /usr/bin/eralchemy
   }
   eralchemy -h
}


echo "eralchemy:"

eralchemy_install
