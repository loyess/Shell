improt_package "utils" "gen_certificates.sh"

# xray-plugin Transport mode
XRAY_PLUGIN_TRANSPORT_MODE=(
ws
wss
quic
)


transport_mode_menu(){
    while true
    do
        echo && echo -e "请为xray-plugin选择 Transport mode\n"
        for ((i=1;i<=${#XRAY_PLUGIN_TRANSPORT_MODE[@]};i++ )); do
            hint="${XRAY_PLUGIN_TRANSPORT_MODE[$i-1]}"
            echo -e "${Green}  ${i}.${suffix} ${hint}"
        done
        echo
        read -e -p "(默认: ${XRAY_PLUGIN_TRANSPORT_MODE[0]}):" libev_xray_plugin
        [ -z "$libev_xray_plugin" ] && libev_xray_plugin=1
        expr ${libev_xray_plugin} + 1 &>/dev/null
        if [ $? -ne 0 ]; then
            echo
            echo -e "${Error} 请输入一个数字"
            echo
            continue
        fi
        if [[ "$libev_xray_plugin" -lt 1 || "$libev_xray_plugin" -gt ${#XRAY_PLUGIN_TRANSPORT_MODE[@]} ]]; then
            echo
            echo -e "${Error} 请输入一个数字在 [1-${#XRAY_PLUGIN_TRANSPORT_MODE[@]}] 之间"
            echo
            continue
        fi

        shadowsocklibev_xray_plugin=${XRAY_PLUGIN_TRANSPORT_MODE[$libev_xray_plugin-1]}
        echo
        echo -e "${Red}  over = ${shadowsocklibev_xray_plugin}${suffix}"
        echo

        break
    done
}

info_display_of_domain(){
    domainType=$1

    echo
    echo -e "${Red}  serverName = ${domain}${suffix} ${Green}(${domainType})${suffix}"
    echo
}

get_input_server_name(){
    while true
    do
        echo
        if [[ ${libev_xray_plugin} = "1" ]] || [[ ${libev_xray_plugin} = "2" ]]; then
            read -e -p "请输入一个域名(CDN 或 DNS-Only)：" domain
        else
            read -e -p "请输入一个域名(DNS-Only)：" domain
        fi

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

        if [[ ${libev_xray_plugin} = "1" ]] || [[ ${libev_xray_plugin} = "2" ]]; then
            if is_cdn_proxied ${domain_ip}; then
                info_display_of_domain "CDN"
                break
            elif is_dns_only ${domain_ip}; then
                info_display_of_domain "DNS-Only"
                break
            else
                echo
                echo -e "${Error} 请输入一个正确有效的域名."
                echo
                continue
            fi
        else
            if is_dns_only ${domain_ip}; then
                info_display_of_domain "DNS-Only"
                break
            else
                echo
                echo -e "${Error} 请输入一个正确有效的域名."
                echo
                continue
            fi
        fi
   done
}

get_input_ws_path(){
    while true
    do
        echo
        read -e -p "请输入你的WebSocket分流路径(默认：/xray)：" path
        [ -z "${path}" ] && path="/xray"
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

get_input_mirror_site(){
    while true
    do
        echo
        echo -e "${Tip} 该站点建议满足(位于海外、支持HTTPS协议、会用来传输大流量... )的条件，默认站点，随意找的，不建议使用"
        read -e -p "请输入你需要镜像到的站点(默认：https://www.bing.com)：" mirror_site
        [ -z "${mirror_site}" ] && mirror_site="https://www.bing.com"
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

check_port_for_xray_plugin(){
    if check_port_occupy "443"; then
        echo -e "${Error} 检测到443端口被占用，请排查后重新运行." && exit 1
    fi
    if [[ ${isEnableWeb} = enable ]]; then
        check_ss_port ${shadowsocksport}
    else
        shadowsocksport=443
    fi
}

xray_plugin_prot_reset(){
    shadowsocksport=$1
    
    if check_port_occupy ${shadowsocksport}; then
        echo -e "${Error} 检测到${shadowsocksport}端口被占用，请排查后重新运行."
        exit 1
    fi
    
    echo
    echo -e "${Tip} Shadowsocks端口已被重置为${Green}${shadowsocksport}${suffix}"
    echo 
}

ws_mode_logic(){
    get_input_ws_path
    is_enable_mux
    improt_package "utils" "web.sh"
    is_enable_web_server
    
    if [[ ${isEnableWeb} == enable ]]; then
        get_input_server_name
        web_server_menu
        check_port_for_xray_plugin
    else
        xray_plugin_prot_reset 80
    fi
    
    if [[ ${web_flag} = "1" ]]; then
        choose_caddy_version_menu
    elif [[ ${web_flag} = "2" ]]; then
        choose_nginx_version_menu
    fi
    
    if [[ ${domainType} = DNS-Only ]] && [[ ${isEnableWeb} = enable ]]; then
        get_input_mirror_site
        acme_get_certificate_by_force "${domain}"
    elif [[ ${domainType} = CDN ]] && [[ ${isEnableWeb} = enable ]]; then
        get_input_mirror_site
        acme_get_certificate_by_api_or_manual "${domain}"
    fi
}

wss_mode_logic(){
    get_input_server_name
    get_input_ws_path
    is_enable_mux
    xray_plugin_prot_reset 443
    
    if [[ ${domainType} = DNS-Only ]]; then
        acme_get_certificate_by_force "${domain}"
    elif [[ ${domainType} = CDN ]]; then
        acme_get_certificate_by_api_or_manual "${domain}"
    fi
}

quic_mode_logic(){
    get_input_server_name
    xray_plugin_prot_reset 443
    acme_get_certificate_by_force "${domain}"
}

install_prepare_libev_xray_plugin(){
    transport_mode_menu

    if [[ ${libev_xray_plugin} = "1" ]]; then
        ws_mode_logic
    elif [[ ${libev_xray_plugin} = "2" ]]; then
        wss_mode_logic
    elif [[ ${libev_xray_plugin} = "3" ]]; then
        quic_mode_logic
    fi
}