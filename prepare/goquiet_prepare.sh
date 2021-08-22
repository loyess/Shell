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
        echo -e "请为GoQuiet输入重定向域名"
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

get_input_webaddr_of_domain(){
    while true
    do
        echo
        echo -e "请为GoQuiet输入与重定向域名对应的IP（默认为自动获取）"
        read -e -p "(默认: ${domain_ip}:443):" gqwebaddr
        [ -z "$gqwebaddr" ] && gqwebaddr="${domain_ip}:443"
        if [ -z "$(echo $gqwebaddr | grep -E ${IPV4_PORT_RE})" ]; then
            echo
            echo -e "${Error} 请输入正确合法的IP:443组合."
            echo
            continue
        fi
        
        echo
        echo -e "${Red}  WebServerAddr = ${gqwebaddr}${suffix}"
        echo
        echo -e "${Tip} SS-libev端口已被重置为${Green}${shadowsocksport}${suffix}"
        echo 
        break
    done
}

get_input_gqkey(){
    echo
    echo -e "请为GoQuiet输入密钥 [留空以将其设置为16位随机字符串]"
    read -e -p "(默认: ${ran_str16}):" gqkey
    [ -z "$gqkey" ] && gqkey=${ran_str16}
    echo
    echo -e "${Red}  Key = ${gqkey}${suffix}"
    echo
}

install_prepare_libev_goquiet(){
    if check_port_occupy "443"; then
        echo -e "${Error} 检测到443端口被占用，请排查后重新运行." && exit 1
    fi
    gen_random_str
    shadowsocksport=443
    get_input_domain
    get_input_webaddr_of_domain
    get_input_gqkey
}

