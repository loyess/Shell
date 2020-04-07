install_acme_tool(){
    # Install certificate generator tools
    if [ ! -e ~/.acme.sh/acme.sh ]; then
        echo
        echo -e "${Info} 开始安装实现了 acme 协议, 可以从 letsencrypt 生成免费的证书的 acme.sh "
        echo
        curl  https://get.acme.sh | sh
        echo
        echo -e "${Info} acme.sh 安装完成. "
        echo
    else
        echo
        echo -e "${Info} 证书生成工具 acme.sh 已经安装，自动进入下一步，请选择. "
        echo
    fi
}

acme_get_certificate_by_force(){
    local domain=$1

    install_acme_tool

    if [ ! "$(command -v socat)" ]; then
        echo -e "${Info} 开始安装强制生成时必要的socat 软件包."
        package_install "socat"
    fi

    echo
    echo -e "${Info} 开始生成域名 ${domain} 相关的证书 "
    echo
    ~/.acme.sh/acme.sh --issue -d ${domain}   --standalone

    cerPath="/root/.acme.sh/${domain}/fullchain.cer"
    keyPath="/root/.acme.sh/${domain}/${domain}.key"

    echo
    echo -e "${Info} ${domain} 证书生成完成. "
    echo
}

get_ip_of_domain(){
    local domain=$1

    ping -h &>nul
    cat nul | grep -qE '4|\-4'
    if [[ $? -eq 0 ]]; then
        domain_ip=`ping -4 ${domain} -c 1 2>nul | sed '1{s/[^(]*(//;s/).*//;q}'`
    else
        domain_ip=`ping ${domain} -c 1 2>nul | sed '1{s/[^(]*(//;s/).*//;q}'`
    fi
    rm -fr ./nul
    if [[ ! -z "${domain_ip}" ]]; then
        return 0
    else
        return 1
    fi
}

is_dns_only(){
    local IP=$1

    echo ${IP} | grep -qP $(get_ip)
    if [[ $? -eq 0 ]]; then
        return 0
    else
        return 1
    fi
}

Info_display_of_domain(){
    domainType=$1

    echo
    echo -e "${Red}  n = ${serverName}${suffix} ${Green}(${domainType})${suffix}"
    echo
}

get_input_server_name(){
    while true
    do
        echo
        read -e -p "请输入一个域名[ DNS-Only 或 Other ] (默认: www.bing.com):" serverName
        [ -z "$serverName" ] && serverName="www.bing.com"
        if ! get_ip_of_domain ${serverName}; then
            echo
            echo -e "${Error} 请输入一个正确有效的域名."
            echo
            continue
        fi

        if is_dns_only ${domain_ip}; then
            Info_display_of_domain "DNS-Only"
            break
        else
            Info_display_of_domain "Other"
            break
        fi
        
   done
}

install_prepare_libev_simple_tls(){
    get_input_server_name
    shadowsocksport=443
    if check_port_occupy "443"; then
        echo -e "${Error} 检测到443端口被占用，请排查后重新运行." && exit 1
    fi
    echo && echo -e "${Tip} Shadowsocks端口已被重置为${Green}${shadowsocksport}${suffix}" && echo
    if [[ ${domainType} = DNS-Only ]]; then
        acme_get_certificate_by_force "${serverName}"
    fi
}

















