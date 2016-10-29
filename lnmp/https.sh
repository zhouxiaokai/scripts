#!/bin/sh

[ $# -lt 2 ] && echo " http.sh  [target dir]"

create_server_key_check(){
    which openssl >/dev/null || {
        echo "no openssl install, install openssl firstly"
        exit 1
    }
    [ x$0 == x ] && {
        echo "no target directory for server.key, pls provide target directory"
        exit 1 
    }
}

create_server_key(){
   [ -f $0/server.key ] && return 
   echo "创建服务器私钥，命令会让你输入一个口令"
   openssl genrsa -des3 -out $0/server.key 1024   
}

create_server_csr(){
   [ -f $0/server.csr ] && return 
   echo "创建签名请求的证书（CSR）"
   openssl req -new -key $0/server.key -out $0/server.csr   
}

create_server_key_org()
{
   [ -f $0/server.key.org ] && return 
   echo "加载SSL支持的Nginx并使用上述私钥时除去必须的口令"
   cp $0/server.key $0/server.key.org
   openssl rsa -in $0/server.key.org -out $0/server.key
}

create_server_crt()
{
    [ -f $0/server.crt ] && return 
    echo "标记证书使用上述私钥和CSR："
    openssl x509 -req -days 365 -in  $0/server.csr -signkey  $0/server.key -out  $0/server.crt
}

gen_nginx_443_conf(){
echo "
#
# HTTPS server configuration
#
server {
    listen       443;
    server_name  本机的IP地址;

    ssl                  on;
    ssl_certificate      /etc/nginx/server.crt;
    ssl_certificate_key  /etc/nginx/server.key;

    ssl_session_timeout  5m;

#    ssl_protocols  SSLv2 SSLv3 TLSv1;
#    ssl_ciphers  ALL:!ADH:!EXPORT56:RC4+RSA:+HIGH:+MEDIUM:+LOW:+SSLv2:+EXP;
#    ssl_prefer_server_ciphers   on;

    location / {
        #root   html;
        #index  testssl.html index.html index.htm;
     proxy_redirect off;
     proxy_set_header Host $host;
     proxy_set_header X-Real-IP $remote_addr;
     proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
     proxy_pass http://IP地址/ssl/;
    }
}" > $0/vhost/443.conf

}

case $1 in

ca)  create_server_key_check $2
     create_server_key $2
     create_server_csr $2
     create_server_key_org $2
     create_server_crt $2
    ;;
conf)[ x$2 == x ] && {
         echo "https.sh conf  [nginx conf path]"
         exit 1
     }
     gen_nginx_443_conf $2;;
     
test)
     nginx -t || exit 1
     echo "nginx configure ok"
     /etc/init.d/nginx restart || exit 1
     netstat -lan | grep 443 && echo "nginx https is running ok"
    ;;
deploy))

;;
esac
