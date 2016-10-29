#!/bin/sh

help(){
  echo $0
  echo "	[server]  [port]  [opts]"
  echo "	[http]  [opts]"
  exit 1
}

help_server()
{
   echo "$0  server"
   echo "  [port]  [ -r root ] [ -i index ]  path "
   exit 1
}


generate_server_https()
{
 echo "https"
 echo '
#
# HTTPS server configuration
#
server {
    listen       443;
    server_name  120.27.138.55;
    ssl                  on;
    ssl_certificate      /etc/nginx/server.crt;
    ssl_certificate_key  /etc/nginx/server.key;

    ssl_session_timeout  5m;

#    ssl_protocols  SSLv2 SSLv3 TLSv1;
#    ssl_ciphers  ALL:!ADH:!EXPORT56:RC4+RSA:+HIGH:+MEDIUM:+LOW:+SSLv2:+EXP;
#    ssl_prefer_server_ciphers   on;

    location / {
     root   /home/wwwroot/www;
     index  testssl.html index.html index.htm index.php;
     include enable-php.conf;
     proxy_redirect off;
     proxy_set_header Host $host;
     proxy_set_header X-Real-IP $remote_addr;
     proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
     #proxy_pass http://120.27.138.55/ssl/;
    }
}' > $1/vhost/443.conf
}

generate_server_http(){
  echo "http"
}


generate_server(){
   echo " $@"
   [ $# -lt 3 ] &&  help_server
   case $2 in 
       443) generate_server_https $3;;
       *)   generate_server_http;;
   esac
}

generate_server_http(){
  echo "http"
}

case $1 in
help) help;;
server) [ $# -lt 2 ] && help_server
       generate_server $@
    ;;
http) echo "generate for http"
       generate_http
    ;;
*) help ;;
esac
