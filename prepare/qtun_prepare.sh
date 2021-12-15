improt_package "utils" "gen_certificates.sh"


print_domain_info(){
    domainType=$1

    echo
    echo -e "${Red}  host = ${domain}${suffix} ${Green}(${domainType})${suffix}"
    echo
}

get_input_domain(){
    while true
    do
        echo
        read -e -p "请输入一个域名(CDN 或 DNS-Only)：" domain

        if [ -z "$domain" ]; then
            echo
            echo -e "${Error} 无默认参数，不能为空，请重新输入."
            echo
            continue
        fi
        
        if ! get_domain_ip ${domain}; then
            echo
            echo -e "${Error} 请输入一个正确有效的域名."
            echo
            continue
        fi

        if is_cdn_proxied ${domain_ip}; then
            print_domain_info "CDN"
            break
        elif is_dns_only ${domain_ip}; then
            print_domain_info "DNS-Only"
            break
        else
            echo
            echo -e "${Error} 请输入一个正确有效的域名."
            echo
            continue
        fi
   done
}

qtun_prot_reset(){
    shadowsocksport=$1
    
    if check_port_occupy ${shadowsocksport}; then
        echo -e "${Error} 检测到${shadowsocksport}端口被占用，请排查后重新运行."
        exit 1
    fi
    
    echo
    echo -e "${Tip} Shadowsocks端口已被重置为${Green}${shadowsocksport}${suffix}"
    echo 
}

install_prepare_libev_qtun(){
    get_input_domain
    qtun_prot_reset 443

    if [[ ${domainType} = DNS-Only ]]; then
        acme_get_certificate_by_force "${domain}" "RSA"
    elif [[ ${domainType} = CDN ]]; then
        acme_get_certificate_by_api_or_manual "${domain}" "RSA"
    fi
}