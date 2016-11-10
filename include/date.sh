#!/bin/sh

getdatetime(){
 echo `date '+%Y-%m-%d-%H-%M-%S'`
}

getdate(){
 echo     `date '+%Y-%m-%d'`
}

gettime(){
echo `date '+%H-%M-%S'`
}

date_test(){
echo "getdatetime=$(getdatetime)"
echo "getdate=$(getdate)"
echo "gettime=$(gettime)"
}

[ "$TEST" == "1" ] && date_test
