#!/bin/sh

replace_help(){
  echo http://blog.csdn.net/werm520/article/details/49334513
}

replace_all(){

local somedir=$1
local matchstring=$2
local repstr=$3
#grep -rl $matchstring $somedir/ | xargs sed -i $repstr  
echo "grep -rl $matchstring $somedir/ | xargs sed -i $repstr"
 grep -rl $matchstring $somedir/
 grep -rl $matchstring $somedir/ | xargs sed -i "$repstr"
#grep -i "windows" -r ./path | awk -F : '{print $1}' | sort | uniq | xargs sed -i 's/windows/linux/g'  
}


replace_files(){
find -name 'test' | xargs perl -pi -e 's|windows|linux|g'  

}

replace_path(){
echo test
##!/bin/bash  
## Our path  
#_r1="/nfs/apache/logs/rawlogs/access.log"  
   
## Escape path for sed using bash find and replace   
#_r1="${_r1//\//\\/}"  
   
# replace __DOMAIN_LOG_FILE__ in our sample.awstats.conf  
#sed -e "s/__DOMAIN_LOG_FILE__/${_r1}/" /nfs/conf/awstats/sample.awstats.conf  > /nfs/apache/logs/awstats/awstats.conf  
   
# call awstats  
#/usr/bin/awstats -c /nfs/apache/logs/awstats/awstats.conf  
}

replace_all $@
