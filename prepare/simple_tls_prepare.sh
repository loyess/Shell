improt_package "utils" "gen_certificates.sh"

# simple-tls Transport mode
SIMPLE_TLS_MODE=(
tls
wss
)


transport_mode_menu(){
    while true
    do
        echo && echo -e "请为simple-tls选择 Transport mode\n"
        for ((i=1;i<=${#SIMPLE_TLS_MODE[@]};i++ )); do
            hint="${SIMPLE_TLS_MODE[$i-1]}"
            echo -e "${Green}  ${i}.${suffix} ${hint}"
        done
        echo
        read -e -p "(默认: ${SIMPLE_TLS_MODE[0]}):" libev_simple_tls
        [ -z "$libev_simple_tls" ] && libev_simple_tls=1
        expr ${libev_simple_tls} + 1 &>/dev/null
        if [ $? -ne 0 ]; then
            echo
            echo -e "${Error} 请输入一个数字"
            echo
            continue
        fi
        if [[ "$libev_simple_tls" -lt 1 || "$libev_simple_tls" -gt ${#SIMPLE_TLS_MODE[@]} ]]; then
            echo
            echo -e "${Error} 请输入一个数字在 [1-${#SIMPLE_TLS_MODE[@]}] 之间"
            echo
            continue
        fi

        shadowsocklibev_simple_tls=${SIMPLE_TLS_MODE[$libev_simple_tls-1]}
        echo
        echo -e "${Red}  over = ${shadowsocklibev_simple_tls}${suffix}"
        echo

        break
    done
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
        if [[ ${libev_simple_tls} = "1" ]]; then
            echo -e "请输入一个域名(DNS-Only 或 Other)"
        elif [[ ${libev_simple_tls} = "2" ]]; then
            echo -e "请输入一个域名(CDN 或 DNS-Only 或 Other)"
        fi
        read -e -p "(默认: www.bing.com):" serverName
        [ -z "$serverName" ] && serverName="www.bing.com"
        if ! get_domain_ip ${serverName}; then
            echo
            echo -e "${Error} 请输入一个正确有效的域名."
            echo
            continue
        fi

        if [[ ${libev_simple_tls} = "1" ]]; then
            if is_dns_only ${domain_ip}; then
                Info_display_of_domain "DNS-Only"
                break
            else
                Info_display_of_domain "Other"
                break
            fi
        elif [[ ${libev_simple_tls} = "2" ]]; then
            if is_cdn_proxied ${domain_ip}; then
                Info_display_of_domain "CDN"
                break
            elif is_dns_only ${domain_ip}; then
                Info_display_of_domain "DNS-Only"
                break
            else
                Info_display_of_domain "Other"
                break
            fi
        fi
   done
}

get_input_wss_path(){
    while true
    do
        echo
        read -e -p "请输入你的WebSocket分流路径(默认：/simple)：" wssPath
        [ -z "${wssPath}" ] && wssPath="/simple"
        if [[ $wssPath != /* ]]; then
            echo
            echo -e "${Error} 请输入以${Red} / ${suffix}开头的路径."
            echo
            continue
        fi
        echo
        echo -e "${Red}  wssPath = ${wssPath}${suffix}"
        echo
        break
    done
}

is_add_random_header(){
    while true
    do
        echo
        echo -e "是否启用 random header(512b~16Kb)，以防止流量分析(rh)"
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
        echo -e "${Red}  rh = ${isEnable}${suffix}"
        echo
        break
    done
}

check_port_for_simple_tls(){
    shadowsocksport=443

    if check_port_occupy "443"; then
        echo -e "${Error} 检测到443端口被占用，请排查后重新运行." && exit 1
    fi
}

install_prepare_libev_simple_tls(){
    transport_mode_menu
    get_input_server_name
    is_add_random_header
    check_port_for_simple_tls

    if [[ ${libev_simple_tls} = "1" ]]; then
        if [[ ${domainType} = DNS-Only ]]; then
            acme_get_certificate_by_force "${serverName}"
        fi
    elif [[ ${libev_simple_tls} = "2" ]]; then
        get_input_wss_path

        if [[ ${domainType} = DNS-Only ]]; then
            acme_get_certificate_by_force "${serverName}"
        elif [[ ${domainType} = CDN ]]; then
            acme_get_certificate_by_api_or_manual "${serverName}"
        fi
    fi
}