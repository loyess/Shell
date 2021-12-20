improt_package "utils" "gen_certificates.sh"


# gun Transport mode
GUN_TRANSPORT_MODE=(
grpc-with-tls
grpc-without-tls
)


transport_mode_menu(){
    while true
    do
        echo && echo -e "请为gun选择 Transport mode\n"
        for ((i=1;i<=${#GUN_TRANSPORT_MODE[@]};i++ )); do
            hint="${GUN_TRANSPORT_MODE[$i-1]}"
            echo -e "${Green}  ${i}.${suffix} ${hint}"
        done
        echo
        read -e -p "(默认: ${GUN_TRANSPORT_MODE[0]}):" libev_gun
        [ -z "$libev_gun" ] && libev_gun=1
        expr ${libev_gun} + 1 &>/dev/null
        if [ $? -ne 0 ]; then
            echo
            echo -e "${Error} 请输入一个数字"
            echo
            continue
        fi
        if [[ "$libev_gun" -lt 1 || "$libev_gun" -gt ${#GUN_TRANSPORT_MODE[@]} ]]; then
            echo
            echo -e "${Error} 请输入一个数字在 [1-${#GUN_TRANSPORT_MODE[@]}] 之间"
            echo
            continue
        fi

        shadowsocklibev_gun=${GUN_TRANSPORT_MODE[$libev_gun-1]}
        echo
        echo -e "${Red}  over = ${shadowsocklibev_gun}${suffix}"
        echo

        break
    done
}

print_domain_info(){
    domainType=$1

    echo
    echo -e "${Red}  domain = ${domain}${suffix} ${Green}(${domainType})${suffix}"
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

gun_prot_reset(){
    shadowsocksport=$1
    
    if check_port_occupy ${shadowsocksport}; then
        echo -e "${Error} 检测到${shadowsocksport}端口被占用，请排查后重新运行."
        exit 1
    fi

    echo
    echo -e "${Tip} Shadowsocks端口已被重置为${Green}${shadowsocksport}${suffix}"
    echo 
}

grpc_with_tls_mode_logic(){
    get_input_domain
    gun_prot_reset 443

    if [[ ${domainType} = DNS-Only ]]; then
        acme_get_certificate_by_force "${domain}"
    elif [[ ${domainType} = CDN ]]; then
        acme_get_certificate_by_api_or_manual "${domain}"
    fi
}

install_prepare_libev_gun(){
    transport_mode_menu

    if [[ ${libev_gun} = "1" ]]; then
        grpc_with_tls_mode_logic
    fi
}