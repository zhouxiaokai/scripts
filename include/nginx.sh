#!/bin/sh

enable_csof(){

print_color "https://blog.fbzl.org/access-control-allow-origin-%E8%A7%A3%E5%86%B3%E8%B7%A8%E5%9F%9F%E6%9D%83%E9%99%90%E9%97%AE%E9%A2%98/"
add_header Access-Control-Allow-Origin *;
add_header Access-Control-Allow-Headers X-Requested-With;
add_header Access-Control-Allow-Methods GET,POST,OPTIONS;

}
