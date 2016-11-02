#!/bin/sh


nginx_rules_return()
{
#return (301 | 302 | 303 | 307) url;
#return (1xx | 2xx | 4xx | 5xx) ["text"];
url=www.go3c.tv
echo "return 301 \$scheme://$url\$request_uri;"
}
#only return 301, 302
#rewrite regex URL [flag];
nginx_rules_rewrite(){
echo '
 rewrite ^(/download/.*)/media/(.*)\..*$ $1/mp3/$2.mp3 last;
 rewrite ^(/download/.*)/audio/(.*)\..*$ $1/mp3/$2.ra  last;
 return  403;'
echo'
#Drop request for unsupport files
location ~ \.(aspx|php|jsp|cgi)$ {
    return 410;
}
location ~ \.(aspx|php|jsp|cgi)$ {
    deny all;
}
#Customer router
rewrite ^/listings/(.*)$ /listing.html?listing=$1 last;
'
echo "$0"
} 


nginx_rules_try_files(){
echo '
location /images/ {
    try_files $uri $uri/ /images/default.gif;
}

location = /images/default.gif {
    expires 30s;
}
'
echo "$0"
}
nginx_rules_return
nginx_rules_rewrite
nginx_rules_try_files
