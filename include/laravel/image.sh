#!/bin/sh

cbcaio_image_attacher(){
   print_color "https://github.com/CbCaio/Image-Attacher"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
	composer require cbcaio/image-attacher
   }	
	config_app_insert      $wdir   "CbCaio\\\ImgAttacher\\\Providers\\\ImgAttacherServiceProvider::class"

   [ -d ./vendor ] && {
      php artisan vendor:publish
   }
}
cviebrock_image_validator(){
   print_color "https://github.com/cviebrock/image-validator"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor ] && {
     composer require "cviebrock/image-validator:^2.1"
   }
     config_app_insert      $wdir   "\\\Cviebrock\\\ImageValidator\\\ImageValidatorServiceProvider::class"
   [ -d ./vendor ] && php artisan vendor:publish
   echo "Image_size"
   echo "$rules = [
    		'my_image_field' => 'image_size:<width>[,<height>]',
	];"
   echo "	width/height:300|<300|<=300|>300|>=300|200-300|*"
   echo "image_aspect:<ratio>"
   echo "	0.75|3,4|~3,4"
}

sahusoftcom_eloquent_image_mutator(){
   print_color "https://github.com/sahusoftcom/eloquent-image-mutator"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor/sahusoftcom/eloquent-image-mutator ] || {
       mkdir -p ./vendor/sahusoftcom
       cd ./vendor/sahusoftcom
       git clone https://github.com/zhouxiaokai/eloquent-image-mutator eloquent-image-mutator || exit 1
       cd ../../
   }
   classmap_insert     $wdir "vendor/sahusoftcom/eloquent-image-mutator/"
   [ -d ./vendor ] && composer dump-autoload
   config_app_insert      $wdir   "SahusoftCom\\\EloquentImageMutator\\\EloquentImageMutatorProvider::class"
   [ -d ./vendor ] && {
      php artisan vendor:publish
   }
}

intervention_image(){
    print_color "https://github.com/Intervention/image"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor/ ] && {
       composer require intervention/image
   }
    config_app_insert         $wdir   "Intervention\\\Image\\\ImageServiceProvider::class"
    config_app_alias_insert   $wdir   "Image" "Intervention\\\Image\\\Facades\\\Image::class"
    [ -d ./vendor ] && {
       php artisan vendor:publish --provider="Intervention\Image\ImageServiceProviderLaravel5"
       php artisan vendor:publish
    }
}

creativeorange_gravatar(){
   print_color "https://github.com/creativeorange/gravatar"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor/ ] && {
       composer require creativeorange/gravatar ~1.0
   }
   config_app_insert         $wdir   "Creativeorange\\\Gravatar\\\GravatarServiceProvider::class"
   config_app_alias_insert   $wdir   "Gravatar" "Creativeorange\\\Gravatar\\\Facades\\\Gravatar::class"
}

bkwld_croppa(){
   print_color "https://github.com/BKWLD/croppa"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor/ ] && {
     composer require bkwld/croppa  ~4.0 || exit 1
   }
   config_app_insert         $wdir   "Bkwld\\\Croppa\\\ServiceProvider::class"
   config_app_alias_insert   $wdir   "Croppa" "Bkwld\\\Croppa\\\Facade::class"
}

spatie_laravel_glide(){
   print_color "https://github.com/spatie/laravel-glide"
   local wdir=$1
   pushd $wdir || exit 1
   [ -d ./vendor/ ] && {
     composer require spatie/laravel-glide  || exit 1
   }
   config_app_insert         $wdir   "Spatie\\\Glide\\\GlideServiceProvider::class"
   config_app_alias_insert   $wdir   "GlideImage" "Spatie\\\Glide\\\GlideImageFacade::class"
   [ -d ./vendor ] && {
     php artisan vendor:publish --provider="Spatie\Glide\GlideServiceProvider"
   }
}

lklore_image(){
   print_color "https://github.com/Folkloreatelier/laravel-image"
   local wdir=$1
   pushd $wdir || exit 1
   require_insert $wdir "folklore/image" "0.3.*"
   [ -d ./vendor/ ] && {
        composer update || exit 1
    }
   config_app_insert         $wdir   "Folklore\\\Image\\\ImageServiceProvider::class"
   config_app_alias_insert   $wdir   "Image" "Folklore\\\Image\\\Facades\\\Image::class"
   [ -d ./vendor ] && {
     php artisan vendor:publish --provider="Folklore\Image\ImageServiceProvider"
   }

}

image_help(){
   echo "Image Command:"
   echo "	cbcaio_image_attacher: uses polymorphic relationships to easily attach images to models"
   echo "	cviebrock_image_validator"
   echo "	sahusoftcom_eloquent_image_mutator"
   echo "	intervention_image"
   echo "	creativeorange_gravatar"
   echo "	bkwld_croppa: URL basic image manuplate basing GD"
   echo "	spatie_laravel_glide: "
   echo "	lklore_image: URL basic image manuplate basing Imagine"
}

image_help
