#!/bin/sh

help(){
  echo $0
  echo "	[server] [host] [port]  [opts]"
  echo "	[http]  [opts]"
  exit 1
}

help_server()
{
   echo "$0  server"
   echo " [host] [port]  [ -r root ] [ -i index ]  path "
   exit 1
}


generate_server_https()
{
 echo "https"
 [ -d $1/vhost ] || mkdir -p $1/vhost
 conf=$1/vhost/443.conf
 server_name=$3
 echo "
#
# HTTPS server configuration
#
server {
    listen       443;
    server_name  $server_name;
    ssl                  on;
    ssl_certificate      /etc/nginx/server.crt;
    ssl_certificate_key  /etc/nginx/server.key;

    ssl_session_timeout  5m;" > $conf
 echo '   

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
     #proxy_pass http://hostip/ssl/;
    }
}' > $1/vhost/443.conf
}

generate_server_http(){
  [ -d $1/vhost ] || mkdir -p $1/vhost
  conf=$1/vhost/$2.conf
  server_name=$3
  echo " server
        {
        listen $2 default_server;
        server_name $3;
        index index.html index.htm index.php;
        root  /home/wwwroot/admin;
        #error_page   404   /404.html;
        include enable-php.conf; "  >> $conf
  echo  'location /nginx_status
        {
            stub_status on;
            access_log   off;
        }

        location ~ .*\.(gif|jpg|jpeg|png|bmp|swf)$
        {
            expires      30d;
        }

        location ~ .*\.(js|css)?$
        {
            expires      12h;
        }

        location ~ /\.
        {
            deny all;
        }

location ~ /services/.*$ {
        if ($server_port ~ ' >> $conf
 echo -e  "\"^$2\c" >> $conf
 echo '$"){
            set $rule_0 1$rule_0;
        }
        if ($rule_0 = "1"){
            rewrite /(.*) ' >>$conf 
 echo -e "https://$server_name/\c" >>$conf 
 echo '$1 permanent;                       break;
        }
    }

        access_log  /home/wwwlogs/access.log  access;
    }' >> $conf
}


generate_server(){
   echo " $@"
   [ $# -lt 3 ] &&  help_server
   port=$2
   path=$3
   host=$4
  echo "path=$path port=$port"
   case $2 in 
       443) generate_server_https $path $port $host;;
       *)   echo "test $@i";
            generate_server_http  $path $port $host ;
          ;;

   esac
}


case $1 in
help) help;;
server) [ $# -lt 4 ] && help_server
       generate_server $@;
    ;;
http) echo "generate for http"
       generate_http $@;
    ;;
*) help ;;
esac
