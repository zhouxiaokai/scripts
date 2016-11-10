#!/bin/sh


port_in_on(){
  iptables -C INPUT -p tcp --dport $1 -j ACCEPT 2>&1 >/dev/null  && return  
  iptables -A INPUT -p tcp --dport $1 -j ACCEPT
   
}

port_output_on(){
   iptables -C OUTPUT -p tcp --sport $1 -j ACCEPT 2>&1 >/dev/null  && return
   iptables -A OUTPUT -p tcp --sport $1 -j ACCEPT
}


port_forward_on(){
   iptables -C FORWARD -p tcp --sport $1 -j ACCEPT 2>&1 >/dev/null && return
   iptables -A FORWARD -p tcp --sport $1 -j ACCEPT
}



port_in_off(){
   iptables -C INPUT -p tcp --dport $1 -j ACCEPT  2>&1 >/dev/null ||  return
   iptables -D INPUT -p tcp --dport $1 -j ACCEPT

}

port_output_off(){

   iptables -C OUTPUT -p tcp --sport $1 -j ACCEPT 2>&1 >/dev/null || return
   iptables -D OUTPUT -p tcp --sport $1 -j ACCEPT
}


port_forward_off(){
   iptables -C FORWARD -p tcp --sport $1 -j ACCEPT 2>&1 >/dev/null || return
   iptables -D FORWARD -p tcp --sport $1 -j ACCEPT
}

save(){
  /etc/init.d/iptables save
}

ssh_on(){
  local port=$1 
  [ -z "$port" ] && port=22
  grep "^Port.*$port" /etc/ssh/sshd_config || {
    echo "this port not enable from sshd, "
    exit 1
  }
  port_in_on $port
  port_output_on $port
  save
}

ssh_off(){
  local port=$1
  [ -z "$port" ] || {
       port_in_off $port
       port_output_off $port
       save
       exit 0
  }
  local ports=`grep Port /etc/ssh/sshd_config | grep -v "^#" | awk '{print $2}'`
  for  i in $ports
  do 
        echo "i=$i"
        [ "$i" == "22108" ] && continue
        port_in_off  $i
        port_output_off $i
        save
  done
}

https_on(){
  port_in_on 443
  port_output_on 443
  port_forward_on 443
}
https_off(){
  port_in_off 443
  port_output_off 443
  port_forward_off 443
}

port_on(){
  port_in_on $1
  port_output_on $1
  port_forward_on $1
}

port_off(){
  port_in_off $1
  port_output_off $1
  port_forward_off $1
}


drop_all(){
  ssh_on
  iptables -P INPUT DROP
  iptables -P OUTPUT DROP
  iptables -P FORWARD DROP
  save
}

$@


