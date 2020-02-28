select_ss_version_auto(){
    local totalRam=`free | awk '/Mem/ {print $2}'`
    local numLogicalCpu=`cat /proc/cpuinfo | grep "processor" | wc -l`

    if [ $totalRam -lt 1048576 ] && [ $numLogicalCpu -le 1 ]; then
        versionDefault=2
    else
        versionDefault=1
    fi
}

choose_ss_install_version(){
    select_ss_version_auto

    while true
    do
        echo
        echo -e "\n请选择Shadowsocks安装版本"
        echo
        for ((i=1;i<=${#SS_DLV[@]};i++ )); do
            hint="${SS_DLV[$i-1]}"
            echo -e "${Green}  ${i}.${suffix} ${hint}"
        done
        
        echo
        read -e -p "(默认: ${versionDefault}):" pick
        [ -z "$pick" ] && pick=${versionDefault}
        expr ${pick} + 1 &>/dev/null
        if [ $? -ne 0 ]; then
            echo
            echo -e "${Error} 请输入一个数字."
            echo
            continue
        fi
        if [[ "$pick" -lt 1 || "$pick" -gt ${#SS_DLV[@]} ]]; then
            echo
            echo -e "${Error} 请输入一个数字在 [1-${#SS_DLV[@]}] 之间."
            echo
            continue
        fi
        SS_VERSION=${SS_DLV[$pick-1]}

        echo
        echo -e "${Red}  ss = ${SS_VERSION}${suffix}"
        echo
        break
    done
}

install_prepare_port() {
    while true
    do
        gen_random_prot
        echo -e "\n请输入Shadowsocks端口 [1-65535]"
        read -e -p "(默认: ${ran_prot}):" shadowsocksport
        [ -z "${shadowsocksport}" ] && shadowsocksport=${ran_prot}
        expr ${shadowsocksport} + 1 &>/dev/null
        if [ $? -ne 0 ]; then
            echo
            echo -e "${Error} 请输入一个有效数字."
            echo
            continue
        fi
        if [ ${shadowsocksport:0:1} = 0 ]; then
            echo
            echo -e "${Error} 请输入一个非0开头的数字."
            echo
            continue
        fi
        if [ ${shadowsocksport} -le 1 ] && [ ${shadowsocksport} -ge 65535 ]; then
            echo
            echo -e "${Error} 请输入一个在1-65535之间的数字."
            echo
            continue
        fi
        if check_port_occupy ${shadowsocksport}; then
            echo
            echo -e "${Error} 该端口已经被占用，请重新输入一个数字."
            echo
            continue
        fi
        echo
        echo -e "${Red}  port = ${shadowsocksport}${suffix}"
        echo 
        break
    done
}

install_prepare_password(){
    gen_random_str
    echo -e "\n请输入Shadowsocks密码"
    read -e -p "(默认: ${ran_str8}):" shadowsockspwd
    [ -z "${shadowsockspwd}" ] && shadowsockspwd=${ran_str8}
    echo
    echo -e "${Red}  password = ${shadowsockspwd}${suffix}"
    echo
}

install_prepare_cipher(){
    while true
    do
        echo -e "\n请选择Shadowsocks加密方式"

        for ((i=1;i<=${#SHADOWSOCKS_CIPHERS[@]};i++ )); do
            hint="${SHADOWSOCKS_CIPHERS[$i-1]}"
            if [[ ${i} -le 9 ]]; then
                echo -e "${Green}  ${i}.${suffix} ${hint}"
            else
                echo -e "${Green} ${i}.${suffix} ${hint}"
            fi
        done
        
        echo
        echo -e "${Tip} rust版本的ss，当中有些加密方式不支持，如：aes-192-gcm"
        echo -e "${Tip} 如果安装成功后，出现无法连接的状况，请换个加密方式再次尝试."
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