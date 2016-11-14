#!/bin/sh
. ./include/string.sh

. ./include/go3c.sh
. ./include/laravel.sh

wdir=$1

[ $# -lt 1 ] &&{
  echo "$0 [wdir]"
  exit 1
} 

go3c_laravel $wdir/resources/views "https://cdn.datatables.net/1.10.12/" "s|https://cdn.datatables.net/1.10.12|http://www.go3c.tv/assets/ajax/libs/datatables/1.10.12|g"
go3c_laravel $wdir/resources/views "//cdn.datatables.net/1.10.12/" "s|//cdn.datatables.net/1.10.12|http://www.go3c.tv/assets/ajax/libs/datatables/1.10.12|g"
go3c_laravel $wdir/resources/views "https://ajax.googleapis.com" "s|https://ajax.googleapis.com|http://www.go3c.tv/assets|g"

go3c_laravel $wdir/resources/views "https://cdn.datatables.net/buttons/" "s|https://cdn.datatables.net/buttons/|http://www.go3c.tv/assets/ajax/libs/datatables/buttons/|g" 
go3c_laravel $wdir/resources/views "https://cdnjs.cloudflare.com" "s|https://cdnjs.cloudflare.com|http://www.go3c.tv/assets|g" 
go3c_laravel $wdir/resources/views "http://maxcdn.bootstrapcdn.com" "s|http://maxcdn.bootstrapcdn.com|http://www.go3c.tv/assets/ajax/libs|g" 
