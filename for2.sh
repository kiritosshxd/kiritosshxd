#!/bin/bash

nums=$(seq 100 299 | tr -s '\n' '|')
nums+=$(seq -s"|" 400 499)
echo -e "Selecione o Range que deseja testar: "
echo -e "[1] - 127.0.0.* "
echo -e "[2] - 127.0.*.* "
echo -e "[3] - 127.*.*.* "
read -p "Opção: " resposta
clear

if [[ "$resposta" = '1' ]]; then
    setup_op1() {
        clear
        echo -e "Defina o ip pra teste (Ex: 127.0.0.): "
        read -p "Range de ip: " range
        read -p "Informe o DOMINIO: " domi
        read -p "Porta: " port
        for i in {1..255}; do
            try=$(curl -m 3 -s -o /dev/null -w "%{http_code}" $domi -H "Upgrade: websocket" -x ${range}${i}:$port)
            ip2="${range}${i}"
            eval "case $try in
                 $nums\ )
                      echo -e \"\e[01;33m$ip2\e[0m | \e[01;37mIP OK - STATUS $try\e[0m\"
                      echo \"$ip2|$try\" >> OK.txt;;
                   *)
                      echo -e \"$ip2 | \e[01;33mSTATUS $try\e[0m\"
           esac"

        done
    }
    setup_op1
elif [[ "$resposta" = '2' ]]; then
    setup_op2() {
        clear
        echo -e "Defina o ip pra teste (Ex: 127.0.): "
        read -p "Range de ip: " range
        read -p "Informe o DOMINIO: " domi
        read -p "Porta: " port
        for q in {1..255}; do
            for i in {1..255}; do
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
    }
    setup_op2
elif [[ "$resposta" = '3' ]]; then
    setup_op3() {
        clear
        echo -e "Defina o ip pra teste (Ex: 127.): "
        read -p "Range de ip: " range
        read -p "Informe o DOMINIO: " domi
        read -p "Porta: " port
        for w in {1..255}; do
            for q in {1..255}; do
                for i in {1..255}; do
                    try=$(curl -m 3 -s -o /dev/null -w "%{http_code}" $domi -H "Upgrade: websocket" -x ${range}${w}.${q}.$i:$port)
                    ip2="${range}${w}.${q}.$i"
                    eval "case $try in
                    $nums\ )
                      echo -e \"\e[01;33m$ip2\e[0m | \e[01;37mIP OK - STATUS $try\e[0m\"
                      echo \"$ip2|$try\" >> OK.txt;;
                   *)
                      echo -e \"$ip2 | \e[01;33mSTATUS $try\e[0m\"
           esac"

                done
            done
        done

    }
    setup_op3
else
    echo ""
    echo -e "\033[1;31mOpcao invalida !\033[0m"
    sleep 1
    exit
fi
