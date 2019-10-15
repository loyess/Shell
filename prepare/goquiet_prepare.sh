get_input_webaddr(){
    IPV4_PORT_RE="^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\:443$"
    while true
    do
        echo
        echo -e "请为GoQuiet输入重定向ip:port [留空以将其设置为bing.com的204.79.197.200:443]"
        read -e -p "(默认: 204.79.197.200:443):" gqwebaddr
        [ -z "$gqwebaddr" ] && gqwebaddr="204.79.197.200:443"
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

get_input_domain_of_webaddr(){
    local DOMAIN_RE="(www\.)?[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+(:\d+)*(\/\w+\.\w+)*$"
    
    while true
    do
        echo
        echo -e "请为GoQuiet输入重定向ip:port相对应的域名"
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
        echo -e "${Red}  ServerName = ${domain}${suffix}"
        echo 
        break
    done
}

get_input_gqkey(){
    echo
    echo -e "请为GoQuiet输入密钥 [留空以将其设置为16位随机字符串]"
    echo
    read -e -p "(默认: ${ran_str16}):" gqkey
    [ -z "$gqkey" ] && gqkey=${ran_str16}
    echo
    echo -e "${Red}  Key = ${gqkey}${suffix}"
    echo
}

install_prepare_libev_goquiet(){
    gen_random_str
    shadowsocksport=443
    get_input_webaddr
    get_input_domain_of_webaddr
    get_input_gqkey
}

