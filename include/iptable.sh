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

dns_output(){

  port_in_on -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT
  port_in_on -p udp -m udp --sport 53 -j ACCEPT
  port_in_on -p udp -m udp --dport 53 -j ACCEPT
  port_in_on -d 192.168.19.108 -p icmp -j ACCEPT
}

dns_on()
{
   iptables -C INPUT -p udp -m udp --sport 53 -j ACCEPT > /dev/null || {
    iptables -A INPUT -p udp -m udp --sport 53 -j ACCEPT
   }
   
   iptables -C INPUT -p udp -m udp --dport 53 -j ACCEPT > /dev/null || {
    iptables -A INPUT -p udp -m udp --dport 53 -j ACCEPT
   }
   iptables -C OUTPUT -p udp -m udp --sport 53 -j ACCEPT > /dev/null || {
    iptables -A OUTPUT  -p udp -m udp --sport 53 -j ACCEPT
   }

   iptables -C OUTPUT -p udp -m udp --dport 53 -j ACCEPT > /dev/null || {
    iptables -A OUTPUT -p udp -m udp --dport 53 -j ACCEPT
   }

}

IFIP=`ifconfig | grep Bcast | awk '{print $2}' | awk -F':' '{print $2}'`

icmp_on(){
   iptables -C INPUT -d $IFIP -p icmp -j ACCEPT > /dev/null || {
    iptables -A INPUT -d $IFIP  -p icmp  -j ACCEPT
   }

   iptables -C OUTPUT -s $IFIP -p icmp -j ACCEPT > /dev/null || {
    iptables -A OUTPUT -s $IFIP -p icmp -j ACCEPT
   }
   iptables -C  INPUT -j REJECT --reject-with icmp-host-prohibited || {
     iptables -A  INPUT -j REJECT --reject-with icmp-host-prohibited
   }

   iptables -C FORWARD -j REJECT --reject-with icmp-host-prohibited || {
     iptables -A FORWARD -j REJECT --reject-with icmp-host-prohibited
   }
}


loop_on(){
   iptables -C INPUT -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT > /dev/null || {
    iptables -A INPUT -s 127.0.0.1  -d 127.0.0.1  -j ACCEPT
   }

   iptables -C OUTPUT -s 127.0.0.1 -d 127.0.0.1  -j ACCEPT > /dev/null || {
    iptables -A OUTPUT -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT
   }
}


init(){
  ssh_on
  loop_on 
  dns_on
  icmp_on
  iptables -P INPUT DROP
  iptables -P OUTPUT DROP
  iptables -P FORWARD DROP
  save
}

$@


