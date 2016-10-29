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
   echo "  [port]  [ -r root ] [ -i index ]"
   exit 1
}


generate_server_https()
{
 echo "https"
}

generate_server_http(){
  echo "http"
}


generate_server(){
   echo " $@"
   case $2 in 
       443) generate_server_https;;
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
