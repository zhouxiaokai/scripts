#!/bin/sh
backslash_dbrm(){
   echo $1 | sed -e 's:\\\\:\.:g'
}
backslash_rm(){
   echo $1 | sed -e 's:\\:\.:g'
}    


backslash_db()
{  
   echo "$1" | sed -e 's:\\:\\\\:g'
} 


require_insert(){
   local dir=$1
   local pkg=$2
   local ver=$3
   grep "$pkg" $dir/composer.json >/dev/null && {
      sed -i "s|^.*$pkg.*,.*$| 	\"$pkg\": \"$ver\",|g" $dir/composer.json && return 0
      sed -i "s|^.*$pkg.*$| 	\"$pkg\": \"$ver\"|g" $dir/composer.json && return 0
      return 1
   }
   sed -i '/^.*laravel\/framework.*$/a \        "'$pkg'": "'$ver'",' $dir/composer.json && return 0
   return 1 
}

classmap_insert(){
   echo "here $1 $2"
   local dir=$1
   local pkg=$2
   grep "$pkg" $dir/composer.json >/dev/null && return 1
   sed -i '/^.*"classmap\":.*\[.*$/a \        	\"'$pkg'\",' $dir/composer.json && return 0
   return 1
}

psr4_append(){
   echo "here $1 $2 $3"
   local dir=$1
   local pkg=$2
   local pkg2=$3
   grep "$pkg" $dir/composer.json >/dev/null && return 1
   
   sed -i 's|^.*App.*app.*$|	\"App\\\\\": \"app/\",|g' $dir/composer.json
   sed -i '/^.*"App.*app.*$/a \          \"'$pkg'\": \"'$pkg2'\"' $dir/composer.json && return 0
   return 1
}

require_insert_dev(){
   local dir=$1
   local pkg=$2
   local ver=$3
   grep "$pkg" $dir/composer.json >/dev/null && {
      sed -i "s|^.*$pkg.*,.*$|  \"$pkg\": \"$ver\",|g" $dir/composer.json && return 0
      sed -i "s|^.*$pkg.*$|     \"$pkg\": \"$ver\"|g" $dir/composer.json && return 0
      return 1
   }
   sed -i '/^.*"require-dev".*$/a \        "'$pkg'": "'$ver'",' $dir/composer.json && return 0
   return 1
}

config_app_insert(){
  local dir=$1
  local pkg=$2 
  grep ".*$pkg" $dir/config/app.php > /dev/null  && return 0
   sed -i '/.*App\\Providers\\AppServiceProvider::class,.*$/i \ 	'$pkg',' $dir/config/app.php

}



config_app_dev_insert(){
  local dir=$1
  local pkg=$2
  local tfile=$dir/app/Providers/AppServiceProvider.php
  grep ".*$pkg" $dir/app/Providers/AppServiceProvider.php > /dev/null  && {
          sed -i "/.*$pkg.*$/d"   $tfile
   }
  grep ".*\$loader.*=.*\\\Illuminate\\\Foundation\\\AliasLoader::getInstance();.*"   $tfile && {
   sed -i '/.*\$loader.*=.*\\Illuminate\\Foundation\\AliasLoader::getInstance();.*$/a \         '$pkg';' $tfile && return 0
  }
  sed -nr  
}


config_app_append(){
  local dir=$1
  local pkg=$2
   echo "$pkg"
   grep "$pkg" $dir/config/app.php  && {
      
      sed -i "/.*$pkg[,]$/d"   $dir/config/app.php
   }

   local tmp=`sed -n '/.*ServiceProvider::class[,]$/h;${x;p}' $dir/config/app.php`
   tmp2=$(backslash_rm "$tmp") 
     
     sed -i "/.*$tmp2.*/a \         $pkg,"                     $dir/config/app.php
    #[ "${tmp:0-1}" != "," ] && sed -i "s/.*$tmp2.*/$tmp,/g"    $dir/config/app.php

 
#  sed -i '/.*App\\Providers\\RouteServiceProvider::class,.*$/a \        '$pkg',' $dir/config/app.php && return 0
#  return 1

}

config_app_alias_insert(){
   local dir=$1
   local pkg=$3
   local alias=$2
   grep "'$alias'" $dir/config/app.php > /dev/null && {
      sed -i '/.*$pkg.*$/d'   $dir/config/app.php 
   }
    sed -i "/.*\\App::class,.*$/i \         '$alias' => $pkg," $dir/config/app.php && return 0
    return 1
}

config_app_alias_append(){
   local dir=$1
   local pkg=$3
   local alias=$2
   grep "'$alias'.*=>" $dir/config/app.php  && {
         sed -i "/.*$alias.*=>.*$/d"   $dir/config/app.php
   }
   local tmp=`sed -n '/.*=>.*/h;${x;p}' $dir/config/app.php | awk -F'=>' '{print $1}'`
   local tmp2=`sed -n '/.*=>.*/h;${x;p}' $dir/config/app.php`  
   local tmp2=$(backslash_db "$tmp2")
   sed -i "/$tmp/a \         '$alias' => $pkg" $dir/config/app.php
   [ "${tmp2:0-1}" != "," ] && sed -i "s/.*$tmp.*/$tmp2,/g" $dir/config/app.php
    return 1
}

package_dep_insert()
{
  local dir=$1
  local pkg=$2
  local ver=$3
  grep "$pkg" $dir/package.json >/dev/null  && {
      sed -i 's/^.*"'$pkg'".*$/	 	"'$pkg'": "'$ver'",/g' $dir/package.json && return 0
      return 1
  }
  sed  -i '/.*devDependencies.*$/a \ 	"'$pkg'": "'$ver'",' $dir/package.json  && return 0
  return 1
}

routemw_insert(){
  local dir=$1
  local alias=$2
  local pkg=$3
  grep "'$alias'" $dir/app/Http/Kernel.php > /dev/null && {
    print_color "there are alias found, check"
    return 1
  } 
  sed -i "/.*protected.*routeMiddleware.*$/a \     '$alias' => $pkg," $dir/app/Http/Kernel.php && return 0
  return 1 
}
mw_insert(){
  local dir=$1
  local pkg=$2
  grep "'$pkg'" $dir/app/Http/Kernel.php > /dev/null && {
    print_color "there are alias found, check"
    return 1
  }
  sed -i "/.*protected.*middleware .*$/a \     '$pkg'," $dir/app/Http/Kernel.php && return 0
  return 1
}

composer_update(){
  local wdir=$1
  pushd $wdir || exit 1
  composer update
  popd
}
composer_install(){
  local wdir=$1
  pushd $wdir || exit 1
  composer install
  popd
}
