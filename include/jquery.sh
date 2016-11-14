#!/bin/sh


bootstrap(){

echo "test $@"
   local tdir=$1
   local ver=$2
   [ -z $ver ] && ver="3.3.6"
   local rel=$3
   local troot=$tdir/bootstrap/$ver
   local url="https://cdn.bootcss.com/bootstrap/$ver"
   local pkgs="bootstrap bootstrap-theme"  
  
   [ -d $troot/css/ ] || mkdir -p $troot/css
   for pkg in $pkgs 
   do 
       [ -f $troot/css/$pkg.css ] || wget $url/css/$pkg.css -O $troot/css/$pkg.css
       [ -f $troot/css/$pkg.min.css ] || wget $url/css/$pkg.min.css -O $troot/css/$pkg.min.css
   done 
 
   local pkgs="bootstrap"  
   [ -d $troot/js/ ] || mkdir -p $troot/js
   for pkg in $pkgs 
   do 
       [ -f $troot/js/$pkg.js ] || wget $curl/js/$pkg.js -O $troot/js/$pkg.js
       [ -f $troot/js/$pkg.min.js ] || wget $url/js/$pkg.min.js -O $troot/js/$pkg.min.js
   done 

   local pkgs="glyphicons-halflings-regular.svg"
   [ -d $troot/fonts ] || mkdir -p $troot/fonts
   for pkg in $pkgs
   do
       [ -f $troot/fonts/$pkg ] || wget $url/fonts/$pkg -O $troot/fonts/$pkg
   done 

}


font_awesome(){

   local tdir=$1
   local ver=$2
   local rel=$3
   
   [ -z $ver ] && ver="4.5.0"
   local troot=$tdir/font-awesome/$ver/
   local url="http://cdn.bootcss.com/font-awesome/$ver"
   local pkgs="font-awesome"
   [ -d $troot/css ] || mkdir -p $troot/css
   [ -d $troot/fonts ] || mkdir -p $troot/fonts
   for pkg in $pkgs 
   do
      [ -f $troot/css/$pkg.css ] || wget $url/css/$pkg.css -O $troot/css/$pkg.css 
      [ -f $troot/css/$pkg.min.css ] || wget $url/css/$pkg.min.css -O $troot/css/$pkg.min.css 
   done
   
   local pkgs="fontawesome-webfont.svg"
   [ -d $troot/fonts ] || mkdir -p $troot/fonts
   for pkg in $pkgs
   do
       [ -f $troot/fonts/$pkg ] || wget $url/fonts/$pkg -O $troot/fonts/$pkg
   done
}

ionicons(){
   local tdir=$1
   local ver=$2
   local rel=$3
   [ -z $ver ] && ver="2.0.1"
   local troot=$tdir/ionicons/$ver
   [ -d $troot/css/ ] || mkdir -p $troot/css/
   local url="http://cdn.bootcss.com/ionicons/$ver/css"
  [ -f $troot/css/ionicons.min.css ] ||  wget $url/ionicons.min.css -O  $troot/css/ionicons.min.css
  [ -f $troot/css/ionicons.min.css ] ||  wget $url/ionicons.css -O  $troot/css/ionicons.css
}

admin_lte(){


   local tdir=$1
   local ver=$2
   local rel=$3
   [ -z $ver ] && ver="2.3.3"
   local troot=$tdir/admin-lte/$ver
   [ -d  $troot/css/skins ] || mkdir -p  $troot/css/skins
   [ -d  $troot/js/pages ] || mkdir -p  $troot/js/pages
   local url="http://cdn.bootcss.com/admin-lte/$ver/"

   [ -f $troot/css/AdminLTE.min.css ] || wget $url/css/AdminLTE.min.css -O  $troot/css/AdminLTE.min.css
   [ -f $troot/css/AdminLTE.css ] || wget $url/css/AdminLTE.css -O  $troot/css/AdminLTE.css

   [ -f  $troot/css/skins/_all-skins.min.css ] || wget $url/css/skins/_all-skins.min.css -O $troot/css/skins/_all-skins.min.css
   [ -f  $troot/css/skins/_all-skins.css ] || wget $url/css/skins/_all-skins.css -O $troot/css/skins/_all-skins.css

   
   [ -f $troot/js/app.min.js ] || wget $url/js/app.min.js -O $troot/js/app.min.js
   [ -f $troot/js/app.js ] || wget $url/js/app.js -O $troot/js/app.js
   [ -f $troot/js/demo.js ] || wget $url/js/demo.js -O $troot/js/demo.js
   [ -f $troot/js/pages/dashboard.js ] || wget $url/js/pages/dashboard.js -O $troot/js/pages/dashboard.js
   [ -f $troot/js/pages/dashboard2.js ] || wget $url/js/pages/dashboard2.js -O $troot/js/pages/dashboard2.js

}

jquery(){

   local tdir=$1
   local ver=$2
   local rel=$3
   [ -z $ver ] && ver="1.12.0"
   local troot=$tdir/jquery/$ver
   [ -d $troot ] || mkdir -p $troot
   [ -f $troot/jquery.js ] || wget http://ajax.aspnetcdn.com/ajax/jQuery/jquery-$ver.js -O $troot/jquery.js
   [ -f $troot/jquery.min.js ] || wget http://ajax.aspnetcdn.com/ajax/jQuery/jquery-$ver.min.js -O $troot/jquery.min.js
   [ -f $troot/jquery.min.map ] ||  wget http://ajax.aspnetcdn.com/ajax/jQuery/jquery-$ver.min.map -O  $troot/jquery.min.map

}

#http://www.bootcdn.cn/datatables/

datatables(){
   local tdir=$1
   local ver=$2
   local rel=$3
   [ -z $ver ] && ver="1.10.12"
   local troot=$tdir/datatables/$ver
   local url="http://cdn.bootcss.com/datatables/$ver"
   [ -d $troot/css ] || mkdir -p  $troot/css 
   [ -d $troot/js  ] || mkdir -p  $troot/js 

   local pkgs="jquery.dataTables  dataTables.uikit  dataTables.semanticui dataTables.material  dataTables.foundation dataTables.jqueryui  dataTables.bootstrap  dataTables.bootstrap4"
   for pkg in $pkgs
   do
     [ -f $troot/css/$pkg.css ] || wget $url/css/$pkg.css -O $troot/css/$pkg.css
     [ -f $troot/js/$pkg.js ] || wget $url/js/$pkg.js -O $troot/js/$pkg.js
     [ -f $troot/css/$pkg.min.css ] || wget $url/css/$pkg.min.css -O $troot/css/$pkg.min.css
     [ -f $troot/js/$pkg.min.js ] || wget $url/js/$pkg.min.js -O $troot/js/$pkg.min.js
   done
    [ -f $troot/css/jquery.dataTables_themeroller.css  ] || wget $url/css/jquery.dataTables_themeroller.css -O $troot/css/jquery.dataTables_themeroller.css
   
   local ver="1.1.2"
   local troot=$tdir/datatables-colvis/$ver
   local url="http://cdn.bootcss.com/datatables-colvis/$ver"
   local pkgs="dataTables.colVis  dataTables.colvis.jqueryui"
   
   [ -d $troot/css ] || mkdir -p $troot/css
   [ -d $troot/js ] || mkdir -p $troot/js
 
   for pkg in $pkgs
   do
          [ -f $troot/css/$pkg.css ] || wget $url/css/$pkg.css -O $troot/css/$pkg.css
          [ -f $troot/css/$pkg.min.css ] || wget $url/css/$pkg.min.css -O $troot/css/$pkg.min.css
   done
   local pkgs="dataTables.colVis"
   for pkg in $pkgs
   do
          [ -f $troot/js/$pkg.js ] || wget $url/js/$pkg.js -O $troot/js/$pkg.js
          [ -f $troot/js/$pkg.min.js ] || wget $url/js/$pkg.min.js -O $troot/js/$pkg.min.js
   done 

   local ver="2.1.1"
   local troot=$tdir/datatables-fixedheader/$ver
   local url="http://cdn.bootcss.com/datatables-fixedheader/$ver"

   [ -d $troot/css ] || mkdir -p $troot/css
   [ -d $troot/js ] || mkdir -p $troot/js

   local pkgs="dataTables.fixedHeader"
   for pkg in $pkgs
   do
          [ -f $troot/$pkg.js ] || wget $url/$pkg.js -O $troot/$pkg.js
          [ -f $troot/$pkg.min.js ] || wget $url/$pkg.min.js -O $troot/$pkg.min.js
   done

   local url="https://www.datatables.net/releases"
   local troot=$tdir/datatables/extensions/
   local extpkgs="AutoFill-2.1.2 Buttons-1.2.2  ColReorder-1.3.2  FixedColumns-3.2.2 FixedHeader-3.1.2  KeyTable-2.1.3 Responsive-2.1.0 Scroller-1.4.2 Select-1.2.0"
   for pkg in $extpkgs
   do
          [ -d $troot/$pkg ] && continue
          wget $url/$pkg.zip -O /tmp/$pkg.zip || exit 1
          unzip -x /tmp/$pkg.zip -d $troot/  || exit 1
          rm -rf /tmp/$pkg.zip
   done
   #https://github.com/DataTables/Plugins/tree/1.10.12
   local troot=$tdir/datatables/plugins
   local url="https://github.com/DataTables/Plugins"

    [ -d $troot ] || git clone --depth=1 -b 1.10.12 $url  $troot

   local tbver="1.2.2"
   local troot=$tdir/datatables/buttons/$tbver
   local url="https://cdn.datatables.net/buttons/$tbver"
   local pkgs="dataTables.buttons buttons.bootstrap buttons.colVis"
   
   [ -d $troot/js ] || mkdir -p   $troot/js

   for pkg in $pkgs
   do
        [ -f $troot/js/$pkg.js ] || wget $url/js/$pkg.js -O $troot/js/$pkg.js
        [ -f $troot/js/$pkg.min.js ] || wget $url/js/$pkg.js -O $troot/js/$pkg.min.js
		
   done

}

#http://www.bootcdn.cn/

select2(){
   local tdir=$1
   local ver=$2
   local rel=$3
   [ -z $ver ] && ver="4.0.2"
   local troot=$tdir/select2/$ver

   [ -d $troot/css/ ] || mkdir -p $troot/css
   [ -d $troot/js/i18n ] || mkdir -p $troot/js/i18n
   local url="http://cdn.bootcss.com/select2/$ver/" 
    [ -f $troot/css/select2.css ] && wget $url/css/select2.css -O $troot/css/select2.css
    [ -f $troot/css/select2.min.css ] && wget $url/css/select2.css -O $troot/css/select2.min.css
    [ -f $troot/js/select2.min.js ] && wget $url/js/select2.min.js -O $troot/js/select2.min.js
    [ -f $troot/js/select2.js ] && wget $url/js/select2.js -O $troot/js/select2.js
    [ -f $troot/js/select2.full.js ] && wget $url/js/select2.full.js -O $troot/js/select2.full.js
    [ -f $troot/js/select2.full.min.js ] && wget $url/js/select2.full.min.js -O $troot/js/select2.full.min.js
    [ -f $troot/js/i18n/en.js ] || wget $url/js/i18n/en.js -O $troot/js/i18n/en.js
    [ -f $troot/js/i18n/zh-CN.js ] || wget $url/js/i18n/zh-CN.js -O $troot/js/i18n/zh-CN.js
    [ -f $troot/js/i18n/zh-TW.js ] || wget $url/js/i18n/zh-TW.js -O $troot/js/i18n/zh-TW.js

}

iCheck(){
   local tdir=$1
   local ver=$2
   local rel=$3
   [ -z $ver ] && ver="1.0.2"
   local troot=$tdir/iCheck/$ver
   [ -d $troot/skins/flat ] || mkdir -p $troot/skins/flat
   local url="http://cdn.bootcss.com/iCheck/$ver/"
   [ -f $troot/icheck.min.js ] || wget $url/icheck.min.js -O $troot/icheck.min.js
   [ -f $troot/icheck.js ] || wget $url/icheck.js -O $troot/icheck.js
   [ -f $troot/skins/all.css ] || wget $url/skins/all.css -O $troot/skins/all.css
   [ -f $troot/skins/flat/_all.css ] || wget $url/skins/flat/_all.css -O $troot/skins/flat/_all.css
   
}
