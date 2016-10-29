#!/bin/sh

[ $# -lt 2 ] && echo " http.sh [ca|conf|test|deploy] [target dir]"

create_server_key_check(){
    which openssl >/dev/null || {
        echo "no openssl install, install openssl firstly"
        exit 1
    }
    [ x$1 == x ] && {
        echo "no target directory for server.key, pls provide target directory"
        exit 1 
    }
}

create_server_key(){
   [ -f $1/server.key ] && return 
   echo "创建服务器私钥，命令会让你输入一个口令"
   openssl genrsa -des3 -out $1/server.key 1024   
}

create_server_csr(){
   [ -f $1/server.csr ] && return 
   echo "创建签名请求的证书（CSR）"
   openssl req -new -key $1/server.key -out $1/server.csr   
}

create_server_key_org()
{
   [ -f $1/server.key.org ] && return 
   echo "加载SSL支持的Nginx并使用上述私钥时除去必须的口令"
   cp $1/server.key $1/server.key.org
   openssl rsa -in $1/server.key.org -out $1/server.key
}

create_server_crt()
{
    [ -f $1/server.crt ] && return 
    echo "标记证书使用上述私钥和CSR："
    openssl x509 -req -days 365 -in  $1/server.csr -signkey  $1/server.key -out  $1/server.crt
}

help_ca()
{
  [ $# -gt 1 ] && return 
   echo "$0 ca [target path for server key certification]"
   exit 1
}



case $1 in

ca)  help_ca
     path=$2
     [ -d $2 ] || mkdir -p $2
     create_server_key_check $path
     create_server_key $path
     create_server_csr $path
     create_server_key_org $path
     create_server_crt $path
    ;;

test)
     nginx -t || exit 1
     echo "nginx configure ok"
     /etc/init.d/nginx restart || exit 1
     netstat -lan | grep 443 && echo "nginx https is running ok"
    ;;
deploy) echo "do nothing"
;;
esac
