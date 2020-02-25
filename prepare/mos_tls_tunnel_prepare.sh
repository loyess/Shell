transport_mode_menu(){
    while true
    do
        echo -e "请为mos-tls-tunnel选择 Transport mode\n"
        for ((i=1;i<=${#MTT_TRANSPORT_MODE[@]};i++ )); do
            hint="${MTT_TRANSPORT_MODE[$i-1]}"
            echo -e "${Green}  ${i}.${suffix} ${hint}"
        done
        echo
        read -e -p "(默认: ${MTT_TRANSPORT_MODE[0]}):" libev_mtt
        [ -z "$libev_mtt" ] && libev_mtt=1
        expr ${libev_mtt} + 1 &>/dev/null
        if [ $? -ne 0 ]; then
            echo
            echo -e "${Error} 请输入一个数字"
            echo
            continue
        fi
        if [[ "$libev_mtt" -lt 1 || "$libev_mtt" -gt ${#MTT_TRANSPORT_MODE[@]} ]]; then
            echo
            echo -e "${Error} 请输入一个数字在 [1-${#MTT_TRANSPORT_MODE[@]}] 之间"
            echo
            continue
        fi
        
        shadowsocklibev_mtt=${MTT_TRANSPORT_MODE[$libev_mtt-1]}
        echo
        echo -e "${Red}  over = ${shadowsocklibev_mtt}${suffix}"
        echo 
        
        break
    done
}

get_input_server_name(){
    while true
    do
    	echo
    	echo -e "请为mos-tls-tunnel输入用于生成自签证书的域名（任意）"
    	read -e -p "(默认: www.bing.com):" serverName
        [ -z "$serverName" ] && serverName="www.bing.com"
        if [ -z "$(echo $serverName | grep -E ${DOMAIN_RE})" ]; then
            echo
            echo -e "${Error} 请输入正确合法的域名."
            echo
            continue
        fi
        
        echo
    	echo -e "${Red}  n = ${serverName}${suffix}"
        echo
        echo -e "${Tip} SS 端口已被重置为${Green}${shadowsocksport}${suffix}"
        echo 
        break
   done
}

get_input_wss_path(){
    while true
    do 
        echo
        read -e -p "请输入你的WebSocket分流路径(默认：/mtt)：" wssPath
        [ -z "${wssPath}" ] && wssPath="/mtt"
        if [[ $wssPath != /* ]]; then
            echo
            echo -e "${Error} 请输入以${Red} / ${suffix}开头的路径."
            echo
            continue
        fi
        echo
        echo -e "${Red}  wssPath = ${wssPath}${suffix}"
        echo
        break
    done
}

get_input_mux_max_stream() {
    while true
    do
        echo
        echo -e "请输入一个实际TCP连接中的最大复用流数"
        read -e -p "(默认: 4):" muxMaxStream
        [ -z "${muxMaxStream}" ] && muxMaxStream=4
        expr ${muxMaxStream} + 1 &>/dev/null
        if [ $? -ne 0 ]; then
            echo
            echo -e "${Error} 请输入一个有效数字."
            echo
            continue
        fi
        if [ ${muxMaxStream:0:1} = 0 ]; then
            echo
            echo -e "${Error} 请输入一个非0开头的数字."
            echo
            continue
        fi
        if [ ${muxMaxStream} -le 0 ]; then
            echo
            echo -e "${Error} 请输入一个大于0的数字."
            echo
            continue
        fi
        echo
        echo -e "${Red}  muxMaxStream = ${muxMaxStream}${suffix}"
        echo 
        break
    done
}

is_enable_mux(){
    while true
    do
        echo
        echo -e "是否启用多路复用(mux)"
		read -p "(默认: n) [y/n]: " yn
        [ -z "${yn}" ] && yn="N"
        case "${yn:0:1}" in
            y|Y)
                isEnable=enable
                ;;
            n|N)
                isEnable=disable 
                ;;
            *)
                echo
                echo -e "${Error} 输入有误，请重新输入!"
                echo
                continue
                ;;
        esac
        
        echo
        echo -e "${Red}  mux = ${isEnable}${suffix}"
        echo
        break
    done
}

install_prepare_libev_mos_tls_tunnel(){
    transport_mode_menu
    
    shadowsocksport=443
    if check_port_occupy "443"; then
        echo -e "${Error} 检测到443端口被占用，请排查后重新运行." && exit 1
    fi
    
    if [[ ${libev_mtt} = "1" ]]; then
        get_input_server_name
        is_enable_mux
    elif [[ ${libev_mtt} = "2" ]]; then
        get_input_server_name
        get_input_wss_path
        is_enable_mux
    fi
    
    if [[ ${isEnable} == enable ]]; then
        get_input_mux_max_stream
    fi
}