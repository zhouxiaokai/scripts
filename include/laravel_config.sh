#!/bin/sh


laravel_socialite_github(){
  local dir=$1
  local id=$2
  local key=$3
  local redir=$4
  [ -z $id ] && id="9e2fb9b10b75c73d4b9c"
  [ -z $key ] && key="be6c85f066f9f0ee45fd63940ec71524efab370a"
  [ -z "$redir"] && redir="http://www.go3c.tv"
  echo "
GITHUB_CLIENT_ID=$id
GITHUB_CLIENT_SECRET=$key
GITHUB_REDIRECT=$redir
" >> $dir/.env
}

laravel_captcha(){
   local dir=$1
  local id=$2
  local key=$3
  local redir=$4
  [ -z $id ] && id="false"
  [ -z $key ] && key="go3c"
  [ -z "$redir"] && sitekey="http://www.go3c.tv"
  echo "
REGISTRATION_CAPTCHA_STATUS=$id
NOCAPTCHA_SECRET=$key
NOCAPTCHA_SITEKEY=$sitekey
 " >> $dir/.env 
}

laravel_notify_disable(){
  local dir=$1
  echo "
DISABLE_NOTIFIER=true
" >> $dir/.env
}

laravel_session_timeout(){
  local dir=$1
  local status=$2
  [ -z $status ] && status="true"
  local timeout=$3
  [  -z $timeout ] && timeout="60"
  echo "
SESSION_TIMEOUT_STATUS=$status
SESSION_TIMEOUT=$timeout

" >> $dir/.env
}
