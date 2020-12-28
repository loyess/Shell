# cloak encryption method
CLOAK_ENCRYPTION_METHOD=(
plain
aes-128-gcm
aes-256-gcm
chacha20-poly1305
)


auto_get_ip_of_domain(){
    local domain=$1
    local ipv4Re="((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])"
    
    if [ ! "$(command -v nslookup)" ]; then
        if check_sys packageManager yum; then
            package_install "bind-utils" > /dev/null 2>&1
        elif check_sys packageManager apt; then
            package_install "dnsutils" > /dev/null 2>&1
        fi
    fi

    domain_ip=`nslookup ${domain} | grep -E 'Name:' -A 1 | grep -oE $ipv4Re | tail -1`
    if [[ -n "${domain_ip}" ]]; then
        return 0
    else
        return 1
    fi
}

get_input_domain(){
    while true
    do
        echo
        echo -e "请为Cloak输入重定向域名"
        read -e -p "(默认: www.bing.com):" domain
        [ -z "$domain" ] && domain="www.bing.com"
        if [ -z "$(echo $domain | grep -E ${DOMAIN_RE})" ]; then
            echo
            echo -e "${Error} 请输入正确合法的域名."
            echo
            continue
        fi
        
        if ! auto_get_ip_of_domain ${domain}; then
            echo
            echo -e "${Error} 请输入正确合法的域名."
            echo
            continue
        fi
        
        echo
        echo -e "${Red}  ServerName = ${domain}${suffix}"
        echo 
        break
    done
}

get_input_rediraddr_of_domain(){
    local index

    while true
    do
        echo
        echo -e "请选择RedirAddr字段对应的值"
        echo -e "${Green}  1.${suffix} ${domain}"
        echo -e "${Green}  2.${suffix} ${domain_ip} (自动获取)"
        echo
        read -e -p "(默认: ${domain}):" index
        [ -z "$index" ] && index=1
        if [[ "$index" -eq 1 ]]; then
            ckwebaddr=${domain}
        elif [[ "$index" -eq 2 ]]; then
            ckwebaddr=${domain_ip}
        else
            echo
            echo -e "${Error} 请输入一个数字在 [1-2] 之间."
            echo
            continue
        fi
        
        echo
        echo -e "${Red}  RedirAddr = ${ckwebaddr}${suffix}"
        echo 
        check_ss_port ${shadowsocksport}
        break
    done
}

get_cloak_encryption_method(){
    while true
    do
        echo
        echo -e "请为Cloak选择一个加密方式"
 
        for ((i=1;i<=${#CLOAK_ENCRYPTION_METHOD[@]};i++ )); do
            hint="${CLOAK_ENCRYPTION_METHOD[$i-1]}"
            if [[ ${i} -le 9 ]]; then
                echo -e "${Green}  ${i}.${suffix} ${hint}"
            else
                echo -e "${Green} ${i}.${suffix} ${hint}"
            fi
        done
        
        echo
        read -e -p "(默认: ${CLOAK_ENCRYPTION_METHOD[0]}):" encryptionMethod
        [ -z "$encryptionMethod" ] && encryptionMethod=1
        expr ${encryptionMethod} + 1 &>/dev/null
        if [ $? -ne 0 ]; then
            echo
            echo -e "${Error} 请输入一个数字."
            echo
            continue
        fi
        if [[ "$encryptionMethod" -lt 1 || "$encryptionMethod" -gt ${#CLOAK_ENCRYPTION_METHOD[@]} ]]; then
            echo
            echo -e "${Error} 请输入一个数字在 [1-${#CLOAK_ENCRYPTION_METHOD[@]}] 之间."
            echo
            continue
        fi
        encryptionMethod=${CLOAK_ENCRYPTION_METHOD[$encryptionMethod-1]}
 
        echo
        echo -e "${Red}  EncryptionMethod = ${encryptionMethod}${suffix}"
        echo
        break
    done
}


install_prepare_libev_cloak(){
    if check_port_occupy "443"; then
        echo -e "${Error} 检测到443端口被占用，请排查后重新运行." && exit 1
    fi
    get_input_domain
    get_input_rediraddr_of_domain
    get_cloak_encryption_method
}