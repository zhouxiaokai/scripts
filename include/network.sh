#!/bin/sh

getip() {

echo `ifconfig | grep Bcast | awk '{print $2}' | awk -F':' '{print $2}'`

}

getmac() {
echo `ifconfig | grep HWaddr | awk '{print $5}'`
}

network_test() {
echo "getip=$(getip)"
echo "getmac=$(getmac)"
}

[ "$TEST" == "1" ] && network_test
