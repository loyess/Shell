get_input_rediraddr(){
    while true
    do
        echo
        echo -e "请为Cloak输入重定向ip [留空以将其设置为bing.com的204.79.197.200]"
        read -e -p "(默认: 204.79.197.200):" ckwebaddr
        [ -z "$ckwebaddr" ] && ckwebaddr="204.79.197.200"
        if ! is_ipv4_or_ipv6 ${ckwebaddr}; then
            echo
            echo -e "${Error} 请输入正确合法的IP地址."
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

get_input_domain_of_rediraddr(){
    while true
    do
        echo
        echo -e "请为Cloak输入重定向ip相对应的域名"
        read -e -p "(默认: www.bing.com):" domain
        [ -z "$domain" ] && domain="www.bing.com"
        if [ -z "$(echo $domain | grep -E ${DOMAIN_RE})" ]; then
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


install_prepare_libev_cloak(){
    if check_port_occupy "443"; then
        echo -e "${Error} 检测到443端口被占用，请排查后重新运行." && exit 1
    fi
    get_input_rediraddr
    get_input_domain_of_rediraddr
}