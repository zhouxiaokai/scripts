#!/bin/sh

help(){
  echo "$0 [server]  [port]  [opts]"
  echo "$0 [http]  [opts]"
  exit 1
}

help_server()
{
   echo "$0 [server]  [port]  [opts]"
   exit 1
}

[ $# -lt 2 ] && help


generate_server_https()
{

}

generate_server_http(){
  echo "http"
}


generate_server(){
   echo "$0 $@"
   case $1 in 
       443) generate_server_https;;
       *)   generate_server_http;;
   esac
}

generate_server_http(){
  echo "http"
}

case $1 in
help) help;;
server) [ $# -lt 3 ] && help_server
       generate_server $@
    ;;
http) echo "generate for http"
       generate_http
    ;;
esac
