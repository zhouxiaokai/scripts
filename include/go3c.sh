#!/bin/sh

go3c_laravel(){

local wdir=$1
local matchdir=$2
local repstr=$3
 replace_all $1 $2 $3
}
