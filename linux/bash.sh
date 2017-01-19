#!/bin/sh



bash_completion(){
   [ -f /usr/share/bash-completion/lsof ] || {
      sudo yum -y install bash-completion.noarch  || exit 1
   }
}

bash_profile(){
   local FILEN="/home/jzhou/.bash_profile"
   [ -f $FILEN ] || {
    echo "#!/bin/sh" > $FILEN
   }
   grep artisan $FILEN || { 
 	echo ". /usr/share/bash-completion/artisan" >>  $FILEN
   	echo "alias artisan='php \"\$(_get_artisan_dir)/artisan\" --ansi'" >> $FILEN
   }     
}

artisan_anywhere(){
     which artisan || {
                sudo wget -q -O /usr/bin/artisan \
 https://raw.github.com/antonioribeiro/artisan-anywhere/master/artisan.sh

                sudo chmod 755 /usr/bin/artisan
        }
}

artisan_tab_anywhere(){
    bash_completion
    
    [ -f /usr/share//bash-completion/artisan ] || {
           sudo wget -q -O /usr/share//bash-completion/artisan \
 https://raw.github.com/HiroKws/ArtisanBashCompletion/master/artisan.sh || exit 1
           sudo chmod 755 /usr/share//bash-completion/artisan || exit 1

     }
        
   bash_profile 

}
