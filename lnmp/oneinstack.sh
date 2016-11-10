#!/bin/sh

#https://oneinstack.com/

env(){
   [ -f /etc/yum.repo.d/CentOS6-Base-163.repo  ] || sudo wget http://mirrors.163.com/.help/CentOS6-Base-163.repo -O /etc/yum.repo.d/CentOS6-Base-163.repo
   sudo yum -y install wget screen curl python
   sudo yum -y install libicu-devel.x86_64 icu.x86_64
   [ -d /home/build ] || sudo kdir -p /home/build
}

onetime(){
   env
   screen -S oneinstack # screen -r oneinstack
}

src(){
   [ -d /home/build/oneinstack ] || {
    [ -f /home/build/oneinstack-full.tar.gz  ] || {
      #wget http://aliyun-oss.linuxeye.com/oneinstack-full.tar.gz    #阿里云用户下载
      wget http://mirrors.linuxeye.com/oneinstack-full.tar.gz -O /home/build/oneinstack-full.tar.gz|| exit 1    #包含源码，国内外均可下载
      #wget http://mirrors.linuxeye.com/oneinstack.tar.gz    #不包含源码，建议仅国外主机下载
    }
      tar -xzvf /home/build/oneinstack-full.tar.gz -C /home/build/
      
   }
   cd /home/build/oneinstack && sudo  ./install.sh
}

help(){
 echo "$0 [workdir]"
 echo "loading https://oneinstack.com/ for detail"
 exit 1
}
case $1 in
    env)env;;
    src)  env
          src;;
    onetime)onetime;;
    *)help;;
esac
