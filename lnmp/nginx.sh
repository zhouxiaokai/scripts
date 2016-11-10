#!/bin/sh

. ./include/help.sh


enable_php(){

  local tdir=$1
  local sock=$2
  [ -z "$sock" ] && sock="/tmp"
echo '
        location ~ [^/]\.php(/|$)
        {
            try_files $uri =404;
'>$tdir/enable-php.conf
echo "      fastcgi_pass  unix:$sock/php-cgi.sock;" >>$tdir/enable-php.conf
echo '
            fastcgi_index index.php;
            include fastcgi.conf;
        }
'>>$tdir/enable-php.conf

}

enable_php_pathinfo(){
local tdir=$1
  local sock=$2
  [ -z "$sock" ] && sock="/tmp"
echo '
fastcgi_split_path_info ^(.+?\.php)(/.*)$;
set $path_info $fastcgi_path_info;
fastcgi_param PATH_INFO       $path_info;
try_files $fastcgi_script_name =404;
' > $tdir/pathinfo.conf

echo '
        location ~ [^/]\.php(/|$)
        {
'>$tdir/enable-php-pathinfo.conf
echo "      fastcgi_pass  unix:$sock/php-cgi.sock;" >> $tdir/enable-php-pathinfo.conf
echo '
            fastcgi_index index.php;
            include fastcgi.conf;
            include pathinfo.conf;
        }

' >> $tdir/enable-php-pathinfo.conf
}

generate_server_https()
{
 echo "https"
 [ -d $1/vhost ] || sudo mkdir -p $1/vhost
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
' >>$1/vhost/443.conf
echo "root   /home/wwwroot/default;" >> $1/vhost/443.conf
echo '
     index  testssl.html index.html index.htm index.php;
     include enable-php.conf;
     proxy_redirect off;
     proxy_set_header Host $host;
     proxy_set_header X-Real-IP $remote_addr;
     proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
     #proxy_pass http://hostip/ssl/;
    }
}' >> $1/vhost/443.conf
}

generate_server_http(){
  [ -d $1/vhost ] || sudo  mkdir -p $1/vhost
  local conf=$1/vhost/$2.conf
  local server_name=$3
  local root=$4
  echo " server
        {
        listen $2 default_server;
        server_name $3;
        index index.html index.htm index.php;
        root  $4;
        #error_page   404   /404.html;
        include enable-php.conf; "  > $conf
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

        access_log  /home/wwwlogs/access.log;
    }' >> $conf
}

generate_server_root(){

   local root=$1
   local port=$2
   local servername=$3
   [ -d $root ] || sudo mkdir -p $root
   sudo echo "Hello , here is path $root for server:port[$servername-$port] " >> $root/index.html
}


generate_server(){
   echo " $@"
   path=$1
   port=$2
   root=$3
   host=$4
   echo "path=$path port=$port"
   case $port in 
       443) generate_server_https $path $port $host $root;;
       *)   echo "test $@i";
            generate_server_http  $path $port $host $root;;

   esac
   generate_server_root $root $port $host
}



case $1 in
server) 
       param_check $# 5 "server [tdir] [port ] [root] [server name] "
       [ $? == 1 ] && exit 1
       shift
       echo "here $@"
       generate_server $@;
    ;;
http) echo "generate for http"
       generate_http $@;
    ;;
php) param_check $# 1 "php [tdir] [sock path] "
     shift
     enable_php $@
     enable_php_pathinfo $@
    ;;
*) help "[server|http|php] [tdir] [port] [root] [server name]";;
esac
