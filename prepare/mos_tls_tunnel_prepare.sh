improt_package "utils" "gen_certificates.sh"

# mos-tls-tunnel Transport mode
MTT_TRANSPORT_MODE=(
tls
wss
)


transport_mode_menu(){
    while true
    do
        echo && echo -e "请为mos-tls-tunnel选择 Transport mode\n"
        for ((i=1;i<=${#MTT_TRANSPORT_MODE[@]};i++ )); do
            hint="${MTT_TRANSPORT_MODE[$i-1]}"
            echo -e "${Green}  ${i}.${suffix} ${hint}"
        done
        echo
        read -e -p "(默认: ${MTT_TRANSPORT_MODE[0]}):" libev_mtt
        [ -z "$libev_mtt" ] && libev_mtt=1
        expr ${libev_mtt} + 1 &>/dev/null
        if [ $? -ne 0 ]; then
            echo
            echo -e "${Error} 请输入一个数字"
            echo
            continue
        fi
        if [[ "$libev_mtt" -lt 1 || "$libev_mtt" -gt ${#MTT_TRANSPORT_MODE[@]} ]]; then
            echo
            echo -e "${Error} 请输入一个数字在 [1-${#MTT_TRANSPORT_MODE[@]}] 之间"
            echo
            continue
        fi

        shadowsocklibev_mtt=${MTT_TRANSPORT_MODE[$libev_mtt-1]}
        echo
        echo -e "${Red}  over = ${shadowsocklibev_mtt}${suffix}"
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
        if [[ ${libev_mtt} = "1" ]]; then
            echo -e "请输入一个域名(DNS-Only 或 Other)"
        elif [[ ${libev_mtt} = "2" ]]; then
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

        if [[ ${libev_mtt} = "1" ]]; then
            if is_dns_only ${domain_ip}; then
                Info_display_of_domain "DNS-Only"
                break
            else
                Info_display_of_domain "Other"
                break
            fi
        elif [[ ${libev_mtt} = "2" ]]; then
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
        read -e -p "请输入你的WebSocket分流路径(默认：/mtt)：" wssPath
        [ -z "${wssPath}" ] && wssPath="/mtt"
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

get_input_mux_max_stream() {
    while true
    do
        echo
        echo -e "请输入一个实际TCP连接中的最大复用流数"
        read -e -p "(默认: 4):" muxMaxStream
        [ -z "${muxMaxStream}" ] && muxMaxStream=4
        expr ${muxMaxStream} + 1 &>/dev/null
        if [ $? -ne 0 ]; then
            echo
            echo -e "${Error} 请输入一个有效数字."
            echo
            continue
        fi
        if [ ${muxMaxStream:0:1} = 0 ]; then
            echo
            echo -e "${Error} 请输入一个非0开头的数字."
            echo
            continue
        fi
        if [ ${muxMaxStream} -lt 1 ] || [ ${muxMaxStream} -gt 16 ]; then
            echo
            echo -e "${Error} 请输入一个的数字在[1-16]之间."
            echo
            continue
        fi
        echo
        echo -e "${Red}  muxMaxStream = ${muxMaxStream}${suffix}"
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

    if [[ ${isEnable} == enable ]]; then
        get_input_mux_max_stream
    fi
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

check_port_for_mtt(){
    if check_port_occupy "443"; then
        echo -e "${Error} 检测到443端口被占用，请排查后重新运行." && exit 1
    fi
    if [[ ${isEnableWeb} = enable ]]; then
        check_ss_port ${shadowsocksport}
    else
        shadowsocksport=443
    fi
}

install_prepare_libev_mos_tls_tunnel(){
    transport_mode_menu
    get_input_server_name
    check_port_for_mtt

    if [[ ${libev_mtt} = "1" ]]; then
        if [[ ${domainType} = DNS-Only ]]; then
            acme_get_certificate_by_force "${serverName}"
        fi
        is_enable_mux
    elif [[ ${libev_mtt} = "2" ]]; then
        get_input_wss_path
        is_enable_mux

        if [[ ${domainType} != Other ]]; then
            improt_package "utils" "web.sh"
            is_enable_web_server
            if [[ ${isEnableWeb} == enable ]]; then
                web_server_menu
            fi
            if [[ ${web_flag} = "2" ]]; then
                choose_nginx_version_menu
            fi
            check_port_for_mtt
        fi

        if [[ ${domainType} = DNS-Only ]] && [[ ${isEnableWeb} = disable ]]; then
            acme_get_certificate_by_force "${serverName}"
        elif [[ ${domainType} = DNS-Only ]] && [[ ${isEnableWeb} = enable ]]; then
            get_input_mirror_site
            acme_get_certificate_by_force "${serverName}"
        elif [[ ${domainType} = CDN ]] && [[ ${isEnableWeb} = disable ]]; then
            acme_get_certificate_by_api_or_manual "${serverName}"
        elif [[ ${domainType} = CDN ]] && [[ ${isEnableWeb} = enable ]]; then
            get_input_mirror_site
            acme_get_certificate_by_api_or_manual "${serverName}"
        fi
    fi
}