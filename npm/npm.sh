#!/bin/sh
 npm config set registry https://registry.npm.taobao.org
npm install -g nrm --registry=https://registry.npm.taobao.org
nrm ls
npm install -g cnpm --registry=https://registry.npm.taobao.org
