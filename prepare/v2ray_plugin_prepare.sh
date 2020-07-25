improt_package "utils" "gen_certificates.sh"

# v2ray-plugin Transport mode
V2RAY_PLUGIN_TRANSPORT_MODE=(
ws+http
ws+tls+[cdn]
quic+tls+[cdn]
ws+tls+web
ws+tls+web+cdn
)


transport_mode_menu(){
    while true
    do
        echo && echo -e "请为v2ray-plugin选择 Transport mode\n"
        for ((i=1;i<=${#V2RAY_PLUGIN_TRANSPORT_MODE[@]};i++ )); do
            hint="${V2RAY_PLUGIN_TRANSPORT_MODE[$i-1]}"
            echo -e "${Green}  ${i}.${suffix} ${hint}"
        done
        echo
        read -e -p "(默认: ${V2RAY_PLUGIN_TRANSPORT_MODE[0]}):" libev_v2ray
        [ -z "$libev_v2ray" ] && libev_v2ray=1
        expr ${libev_v2ray} + 1 &>/dev/null
        if [ $? -ne 0 ]; then
            echo
            echo -e "${Error} 请输入一个数字"
            echo
            continue
        fi
        if [[ "$libev_v2ray" -lt 1 || "$libev_v2ray" -gt ${#V2RAY_PLUGIN_TRANSPORT_MODE[@]} ]]; then
            echo
            echo -e "${Error} 请输入一个数字在 [1-${#V2RAY_PLUGIN_TRANSPORT_MODE[@]}] 之间"
            echo
            continue
        fi
        
        shadowsocklibev_v2ray=${V2RAY_PLUGIN_TRANSPORT_MODE[$libev_v2ray-1]}
        echo
        echo -e "${Red}  over = ${shadowsocklibev_v2ray}${suffix}"
        echo 
        
        break
    done
}

v2ray_plugin_prot_reset(){
    shadowsocksport=$1
    echo
    echo -e "${Tip} SS-libev端口已被重置为${Green}${shadowsocksport}${suffix}"
    echo 
}

get_input_domain(){
    local text=$1
    echo
    read -e -p "${text}：" domain
    echo
    echo -e "${Red}  host = ${domain}${suffix}"
    echo
}

get_input_host(){
    while true
    do
    	echo
    	echo -e "请为v2ray-plugin输入用于混淆的域名"
    	read -e -p "(默认: www.bing.com):" domain
        [ -z "$domain" ] && domain="www.bing.com"
        if [ -z "$(echo $domain | grep -E ${DOMAIN_RE})" ]; then
            echo
            echo -e "${Error} 请输入正确合法的域名."
            echo
            continue
        fi
        
        echo
    	echo -e "${Red}  host = ${domain}${suffix}"
        echo
        break
   done
}

get_input_ws_path(){
    while true
    do 
        echo
        read -e -p "请输入你的WebSocket分流路径(默认：/v2ray)：" path
        [ -z "${path}" ] && path="/v2ray"
        if [[ $path != /* ]]; then
            echo
            echo -e "${Error} 请输入以${Red} / ${suffix}开头的路径."
            echo
            continue
        fi
        echo
        echo -e "${Red}  path = ${path}${suffix}"
        echo
        break
    done
}

get_input_mirror_site(){
    while true
    do 
        echo
        echo -e "${Tip} 该站点建议满足(位于海外、支持HTTPS协议、会用来传输大流量... )的条件，默认站点，随意找的，不建议使用"
        read -e -p "请输入你需要镜像到的站点(默认：https://www.bostonusa.com)：" mirror_site
        [ -z "${mirror_site}" ] && mirror_site="https://www.bostonusa.com"
        if [ -z "$(echo $mirror_site | grep -E ${HTTPS_DOMAIN_RE})" ]; then
            echo
            echo -e "${Error} 请输入以${Red} https:// ${suffix}开头，以${Red} 域名 ${suffix}结尾的URL."
            echo
            continue
        fi
        
        echo
        echo -e "${Red}  mirror_site = ${mirror_site}${suffix}"
        echo
        break
    done
}

get_input_mux_max_stream() {
    while true
    do
        echo
        echo -e "请输入一个实际TCP连接中的最大复用流数"
        read -e -p "(默认: 4):" mux
        [ -z "${mux}" ] && mux=4
        expr ${mux} + 1 &>/dev/null
        if [ $? -ne 0 ]; then
            echo
            echo -e "${Error} 请输入一个有效数字."
            echo
            continue
        fi
        if [ ${mux:0:1} = 0 ]; then
            echo
            echo -e "${Error} 请输入一个非0开头的数字."
            echo
            continue
        fi
        if [ ${mux} -le 0 ]; then
            echo
            echo -e "${Error} 请输入一个大于0的数字."
            echo
            continue
        fi
        echo
        echo -e "${Red}  mux = ${mux}${suffix}"
        echo
        break
    done
}

is_disable_mux(){
    while true
    do
        echo
        echo -e "是否禁用多路复用(mux)"
		read -p "(默认: n) [y/n]: " yn
        [ -z "${yn}" ] && yn="N"
        case "${yn:0:1}" in
            y|Y)
                isDisable=disable
                ;;
            n|N)
                isDisable=enable
                ;;
            *)
                echo
                echo -e "${Error} 输入有误，请重新输入!"
                echo
                continue
                ;;
        esac
        
        echo
        echo -e "${Red}  mux ${isDisable}${suffix}"
        echo
        break
    done
    
    if [[ ${isDisable} == disable ]]; then
        mux=0
    elif [[ ${isDisable} == enable ]]; then
        get_input_mux_max_stream
    fi
}

print_error_info(){
    local text=$1
    
    echo
    echo -e "${Error} ${text}"
    echo
}

error_info_text(){
    TEXT1="该域名没有被域名服务器解析，请解析后再次尝试."
    TEXT2="该域名在域名服务器处解析的不是本机IP，请确认后再次尝试."
    TEXT3="该域名是否有解析过本机ip地址，如果没有，前往域名服务商解析本机ip地址至该域名，并重新尝试."
    TEXT4="该域名是否由Cloudflare托管并成功解析过本机ip地址，请确认后再次尝试."
}

install_prepare_libev_v2ray(){
    error_info_text
    transport_mode_menu
    improt_package "utils" "web.sh"
    if [[ ${libev_v2ray} = "4" || ${libev_v2ray} = "5" ]]; then
        web_server_menu
    fi
    if [[ ${web_flag} = "1" ]]; then
        choose_caddy_version_menu
    elif [[ ${web_flag} = "2" ]]; then
        choose_nginx_version_menu
    fi
    
 
    if [[ ${libev_v2ray} = "1" ]]; then
        if check_port_occupy "80"; then
            echo -e "${Error} 检测到80端口被占用，请排查后重新运行." && exit 1
        fi
        v2ray_plugin_prot_reset 80
        get_input_host
        get_input_ws_path
        is_disable_mux
        
    elif [[ ${libev_v2ray} = "2" || ${libev_v2ray} = "3" ]]; then
        if check_port_occupy "443"; then
            echo -e "${Error} 检测到443端口被占用，请排查后重新运行." && exit 1
        fi
        v2ray_plugin_prot_reset 443
        
        while true
        do    
            get_input_domain "请输入你的域名(CF->DNS->Proxied status：Proxied或DNS-Only)"
            
            if ! get_domain_ip ${domain}; then
                print_error_info ${TEXT1}
                continue
            fi
            
            if is_cdn_proxied ${domain_ip}; then
                acme_get_certificate_by_api_or_manual ${domain}
                break
            elif is_dns_only ${domain_ip}; then
                acme_get_certificate_by_force ${domain}
                break
            else
                print_error_info ${TEXT2}
                continue
            fi
        done 
        
        if [[ ${libev_v2ray} = "2" ]]; then
            get_input_ws_path
            is_disable_mux
        fi
        
    elif [[ ${libev_v2ray} = "4" ]]; then
        if check_port_occupy "443"; then
            echo -e "${Error} 检测到443端口被占用，请排查后重新运行." && exit 1
        fi
        while true
        do
            get_input_domain "请输入你的域名(CF->DNS->Proxied status：DNS-Only)"
            check_ss_port ${shadowsocksport}
            
            if ! get_domain_ip ${domain}; then
                print_error_info ${TEXT3}
                continue
            fi
            
            if is_dns_only ${domain_ip}; then
                acme_get_certificate_by_force ${domain}
                get_input_ws_path
                get_input_mirror_site
                is_disable_mux
                break
            else
                print_error_info ${TEXT3}
                continue
            fi
        done
    elif [[ ${libev_v2ray} = "5" ]]; then
        if check_port_occupy "443"; then
            echo -e "${Error} 检测到443端口被占用，请排查后重新运行." && exit 1
        fi
        while true
        do
            get_input_domain "请输入你的域名(CF->DNS->Proxied status：Proxied)"
            check_ss_port ${shadowsocksport}
            
            if ! get_domain_ip ${domain}; then
                print_error_info ${TEXT4}
                continue
            fi
            
            if is_cdn_proxied ${domain_ip}; then
                acme_get_certificate_by_api_or_manual ${domain}
                get_input_ws_path
                get_input_mirror_site
                is_disable_mux
                break
            else
                print_error_info ${TEXT4}
                continue
            fi
        done
    fi
}