#!/bin/sh
#http://pkg.phpcomposer.com/
dir=$1

help()
{
  echo "$0 [env|link|project] [dir]"
}

check_env()
{
   which php || {
     echo "no php install"
     exit 1
   } 
   phpv=`php -v | awk 'NR==1{print $2}'`
   case $phpv in
      5.4*|5.5*|5.6*|6.*|7.*) ;;
      *) echo "php $phpv is too older, we need at least 5.3.2"
         exit 1;;
   esac
   echo "php version $phpv"
}

check_composer()
{
   composerv=`composer -V | awk '{print $3}'`
   [ -z "$composerv" ] && { echo "No composer install"  
      exit 1
   }
   [ "$composerv" \< "1.0.0" ] && {
      echo "Composer $composerv is too old , we need at least 1.2.0"
      exit 1
   }
   echo "Composer $composerv"
}

check_doctrine_cli()
{
 
 which doctrine || {
   echo "No doctrine install "
   exit 1
 }
 
 cliv=`php doctrine -V | awk '{ print $6 }'`   
   [ -z "$cliv" ] && { echo "No doctrine Command line install: composer install"
      exit 1
   }
   [ "$cliv" \< "1.0.0" ] && {
      echo "Doctrine Command line  $cliv is too old , we need at least 1.0.0"
      exit 1
   }
   echo "Doctrine Command line  $cliv"
}

link_doctrine()
{
   dir=$1
    [ -L /usr/bin/doctrine ] && {
    sudo   rm -rf /usr/bin/doctrine
    }
    cd $dir
    sudo ln -sf `pwd`/vendor/bin/doctrine /usr/bin/doctrine
}

install_doctrine2_orm_tutorial()
{
   dir=$1
   [ -d $dir/doctrine2-orm-tutorial ] || {
         cd $dir
         git clone --depth=1 https://github.com/doctrine/doctrine2-orm-tutorial
   }
   echo "doctrine2-orm-tutorial found on this dir"
   [ -d $dir/doctrine2-orm-tutorial ] &&  {
        cd $dir/doctrine2-orm-tutorial && composer config repo.packagist composer https://packagist.phpcomposer.com &&  composer install -d . && link_docktrine
   }
}

gen_bootstrap()
{
tfile=$1
echo '
<?php
// bootstrap .php
use Doctrine\ORM\Tools\Setup;
use Doctrine\ORM\EntityManager;
// Create a simple "default" Doctrine ORM configuration for XML Mapping
$isDevMode = true;
$config = Setup::createAnnotationMetadataConfiguration(array(__DIR__."/src"), $isDevMode);
// or if you prefer yaml or annotations
//$config = Setup::createXMLMetadataConfiguration(array(__DIR__."/config/xml"), $isDevMode);
//$config = Setup::createYAMLMetadataConfiguration(array(__DIR__."/config/yaml"), $isDevMode);

// database configuration parameters
$conn = array(
    'driver' => 'pdo_mysql',
     'user'  => 'root',
     'password'  => 'go3c86985773',
     'dbname'  => 'laravel',
     'host' => 'localhost',
     'port' => '3306',
//    'path' => __DIR__ . '/db.sqlite',
);

// obtaining the entity manager
$entityManager = \Doctrine\ORM\EntityManager::create($conn, $config);
' > $tfile/bootstrap.php

}

gen_cli_config()
{
tfile=$1
echo "
<?php
use Doctrine\ORM\Tools\Console\ConsoleRunner;

// replace with file to your own project bootstrap
require_once 'bootstrap.php';

// replace with mechanism to retrieve EntityManager in your app
" > $tfile/cli-config.php 
echo '
return \Doctrine\ORM\Tools\Console\ConsoleRunner::createHelperSet($entityManager);
' >> $tfile/cli-config.php

}

help_project()
{
 echo "$0 project [dir] [project name]"
 exit 1
}

case $1 in 
  env)dir=$2
      [ -z "$dir"  ] && help
      [ -d "$dir" ] || {
          echo "$dir not exist"
          exit 1
       }
      check_env
      check_composer
      install_doctrine2_orm_tutorial  $dir
      check_doctrine_cli $dir;;
  project)
      dir=$2
      prj=$3
      [ $# -lt 3  ] && help_project
      [ -d $dir/$prj/src ] || mkdir -p $dir/$prj/src
	
      gen_bootstrap $dir/$prj
      gen_cli_config $dir/$prj
    ;;
  link) dir=$2
         [ -z "$dir"  ] && help
         [ -d "$dir" ] || {
          echo "$dir not exist"
          exit 1
       }
       link_doctrine $dir;;
  *)help;;
esac
