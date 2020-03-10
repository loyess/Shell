get_input_rabbit_port(){
    while true
    do
        echo
        read -e -p "请输入rabbit-tcp监听端口[1-65535] (默认: 443):" listen_port
        [ -z "${listen_port}" ] && listen_port=443
        expr ${listen_port} + 1 &>/dev/null
        if [ $? -ne 0 ]; then
            echo
            echo -e "${Error} 请输入一个有效数字."
            echo
            continue
        fi
        if [ ${listen_port:0:1} = 0 ]; then
            echo
            echo -e "${Error} 请输入一个非0开头的数字."
            echo
            continue
        fi
        if [ ${listen_port} -lt 1 ] && [ ${listen_port} -gt 65535 ]; then
            echo
            echo -e "${Error} 请输入一个在1-65535之间的数字."
            echo
            continue
        fi
        if [ ${listen_port} -eq ${shadowsocksport} ]; then
            echo
            echo -e "${Error} 请输入一个与SS端口不同的数字."
            echo
            continue
        fi
        if check_port_occupy ${listen_port}; then
            echo
            echo -e "${Error} 该端口已经被占用，请重新输入一个数字."
            echo
            continue
        fi

        echo
        echo -e "${Red}  port = ${listen_port}${suffix}"
        echo
        break
    done
}

get_input_rabbit_password(){
    gen_random_str
    echo
    read -e -p "请输入rabbit-tcp密码 (默认: ${ran_str8}):" rabbitKey
    [ -z "${rabbitKey}" ] && rabbitKey=${ran_str8}
    echo
    echo -e "${Red}  password = ${rabbitKey}${suffix}"
    echo
}

get_input_rabbit_log_level(){
    local LOG_LEVEL=(OFF FATAL ERROR WARN INFO DEBUG)

    while true
    do
        echo -e "请选择rabbit-tcp日志等级\n"
        for ((i=1;i<=${#LOG_LEVEL[@]};i++)); do
            hint="${LOG_LEVEL[$i-1]}"
            echo -e "${Green}  ${i}.${suffix} ${hint}"
        done
        echo
        read -e -p "(默认：${LOG_LEVEL[4]}):" rabbitLevel
        [ -z "$rabbitLevel" ] && rabbitLevel=5
        expr ${rabbitLevel} + 1 &>/dev/null
        if [ $? -ne 0 ]; then
            echo
            echo -e "${Error} 请输入一个数字"
            echo
            continue
        fi
        if [[ "$rabbitLevel" -lt 1 || "$rabbitLevel" -gt ${#LOG_LEVEL[@]} ]]; then
            echo
            echo -e "${Error} 请输入一个数字在 [1-${#LOG_LEVEL[@]}] 之间"
            echo
            continue
        fi

        verbose=${LOG_LEVEL[$rabbitLevel-1]}
        let "rabbitLevel--"

        echo
        echo -e "${Red}  verbose = ${verbose}${suffix}"
        echo

        break
    done
}

install_prepare_libev_rabbit_tcp(){
    get_input_rabbit_port
    get_input_rabbit_password
    get_input_rabbit_log_level
}