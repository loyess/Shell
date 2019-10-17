get_input_obfs_mode(){
    while true
    do
        echo -e "请为simple-obfs选择obfs\n"
        for ((i=1;i<=${#OBFUSCATION_WRAPPER[@]};i++ )); do
            hint="${OBFUSCATION_WRAPPER[$i-1]}"
            echo -e "${Green}  ${i}.${suffix} ${hint}"
        done
        echo
        read -e -p "(默认: ${OBFUSCATION_WRAPPER[0]}):" libev_obfs
        [ -z "$libev_obfs" ] && libev_obfs=1
        expr ${libev_obfs} + 1 &>/dev/null
        if [ $? -ne 0 ]; then
            echo
            echo -e "${Error} 请输入一个数字"
            echo
            continue
        fi
        if [[ "$libev_obfs" -lt 1 || "$libev_obfs" -gt ${#OBFUSCATION_WRAPPER[@]} ]]; then
            echo
            echo -e "${Error} 请输入一个数字在 [1-${#OBFUSCATION_WRAPPER[@]}] 之间"
            echo
            continue
        fi
        shadowsocklibev_obfs=${OBFUSCATION_WRAPPER[$libev_obfs-1]}
        echo
        echo -e "${Red}  obfs = ${shadowsocklibev_obfs}${suffix}"
        echo
        break
    done
}

get_input_domain_of_obfs(){
    while true
    do
    	echo
    	echo -e "请为simple-obfs输入用于混淆的域名"
    	echo
    	read -e -p "(默认: www.bing.com):" domain
   	 [ -z "$domain" ] && domain="www.bing.com"
   	if [ -z "$(echo $domain | grep -E ${DOMAIN_RE})" ]; then
            echo
            echo -e "${Error} 请输入正确合法的域名."
            echo
            continue
        fi
        
   	 echo
    	echo -e "${Red}  obfs-host = ${domain}${suffix}"
   	 echo
   	 break
   done
}

install_prepare_libev_obfs(){
    if ! autoconf_version || centosversion 6; then
        echo
        echo -e "${Info} autoconf 版本小于 2.67，Shadowsocks-libev 插件 simple-obfs 的安装将被终止."
        echo
        exit 1
    fi
    get_input_obfs_mode
    get_input_domain_of_obfs
}

