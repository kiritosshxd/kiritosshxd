#!/bin/bash
echo "Informe o RANGE DE IP: "
read range
echo "Informe o DOMINIO: "
read domi
echo "Porta: "
read port
for q in {0..255}; do
   for i in {0..255}; do
      try=$(curl -m 3 -s -o /dev/null -w "%{http_code}" $domi -H "Upgrade: websocket" -x ${range}${q}.$i:$port)
      ip2="${range}${q}.$i"
      eval "case $try in
                 $nums\ )
                      echo -e \"\e[01;33m$ip2\e[0m | \e[01;37mIP OK - STATUS $try\e[0m\"
                      echo \"$ip2|$try\" >> OK.txt;;
                   *)
                      echo -e \"$ip2 | \e[01;33mSTATUS $try\e[0m\"
           esac"

   done
done

read
