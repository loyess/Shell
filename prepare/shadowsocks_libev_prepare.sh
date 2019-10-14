install_prepare_port() {
    while true
    do
        gen_random_prot
        echo -e "\n请输入Shadowsocks-libev端口 [1-65535]"
        read -e -p "(默认: ${ran_prot}):" shadowsocksport
        [ -z "${shadowsocksport}" ] && shadowsocksport=${ran_prot}
        expr ${shadowsocksport} + 1 &>/dev/null
        if [ $? -eq 0 ]; then
            if [ ${shadowsocksport} -ge 1 ] && [ ${shadowsocksport} -le 65535 ] && [ ${shadowsocksport:0:1} != 0 ]; then
                echo
                echo -e "${Red}  port = ${shadowsocksport}${suffix}"
                echo
                echo -e "${Tip} 插件选择v2ray(1|2|3) goquiet时，该端口将被重置为${Red}80${suffix}或${Red}443${suffix}"
                echo -e "${Tip} 插件选择v2ray(4|5) cloak时，该端口不能是${Red}443${suffix}"
                echo 
                break
            fi
        fi
        echo
        echo -e "${Error} 请输入一个正确的数 [1-65535]"
        echo
    done
}

install_prepare_password(){
    gen_random_str
    echo -e "\n请输入Shadowsocks-libev密码"
    read -e -p "(默认: ${ran_str8}):" shadowsockspwd
    [ -z "${shadowsockspwd}" ] && shadowsockspwd=${ran_str8}
    echo
    echo -e "${Red}  password = ${shadowsockspwd}${suffix}"
    echo
}

install_prepare_cipher(){
    while true
    do
        echo -e "\n请选择Shadowsocks-libev加密方式"

        for ((i=1;i<=${#SHADOWSOCKS_CIPHERS[@]};i++ )); do
            hint="${SHADOWSOCKS_CIPHERS[$i-1]}"
            if [[ ${i} -le 9 ]]; then
                echo -e "${Green}  ${i}.${suffix} ${hint}"
            else
                echo -e "${Green} ${i}.${suffix} ${hint}"
            fi
        done
        
        echo
        read -e -p "(默认: ${SHADOWSOCKS_CIPHERS[14]}):" pick
        [ -z "$pick" ] && pick=15
        expr ${pick} + 1 &>/dev/null
        if [ $? -ne 0 ]; then
            echo
            echo -e "${Error} 请输入一个数字."
            echo
            continue
        fi
        if [[ "$pick" -lt 1 || "$pick" -gt ${#SHADOWSOCKS_CIPHERS[@]} ]]; then
            echo
            echo -e "${Error} 请输入一个数字在 [1-${#SHADOWSOCKS_CIPHERS[@]}] 之间."
            echo
            continue
        fi
        shadowsockscipher=${SHADOWSOCKS_CIPHERS[$pick-1]}

        echo
        echo -e "${Red}  cipher = ${shadowsockscipher}${suffix}"
        echo
        break
    done
}