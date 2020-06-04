# simple-tls Transport mode
SIMPLE_TLS_MODE=(
tls
wss
)


intall_acme_tool(){
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

    intall_acme_tool

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

choose_api_get_mode(){
    if [[ ! -e ~/.api/cf.api ]]; then
        get_input_api_info
    else
        echo
        echo -e "检测到${Green}~/.api/cf.api${suffix}文件存在，开始获取API信息."
        CF_Email=$(cat ~/.api/cf.api | grep "CLOUDFLARE_EMAIL" | cut -d= -f2)
        CF_Key=$(cat ~/.api/cf.api | grep "CLOUDFLARE_API_KEY" | cut -d= -f2)
        echo
        echo -e "${Red}  email = ${CF_Email}${suffix}"
        echo -e "${Red}  key = ${CF_Key}${suffix}"
        echo
    fi
}

acme_get_certificate_by_api(){
    local domain=$1

    choose_api_get_mode
    intall_acme_tool

    echo
    echo -e "${Info} 开始生成域名 ${domain} 相关的证书 "
    echo
    export CF_Key=${CF_Key}
    export CF_Email=${CF_Email}
    ~/.acme.sh/acme.sh --issue --dns dns_cf -d ${domain}

    cerPath="/root/.acme.sh/${domain}/fullchain.cer"
    keyPath="/root/.acme.sh/${domain}/${domain}.key"

    echo
    echo -e "${Info} ${domain} 证书生成完成. "
    echo
}

get_input_api_info(){
    while true
    do
        echo
        read -e -p "请输入Cloudflare用户名(邮箱)：" CF_Email
        if [ -z "$(echo $CF_Email | grep -E ${EMAIL_RE})" ]; then
            echo
            echo -e "${Error} 请输入正确合法的邮箱."
            echo
            continue
        fi

        echo
        echo -e "${Red}  email = ${CF_Email}${suffix}"
        echo
        break
    done

    while true
    do
        echo
        read -e -p "请输入Cloudflare - Global API Key：" CF_Key
        if [[ $(echo ${#CF_Key}) -ne 37 ]]; then
            echo
            echo -e "${Error} 请输入正确合法的Global API Key."
            echo
            continue
        fi

        echo
        echo -e "${Red}  key = ${CF_Key}${suffix}"
        echo
        break
    done

    if [[ ! -e ~/.api ]]; then
        mkdir -p ~/.api
    fi
    local CF_API_FILE=~/.api/cf.api
    echo "CLOUDFLARE_EMAIL=${CF_Email}" > ${CF_API_FILE}
    echo "CLOUDFLARE_API_KEY=${CF_Key}" >> ${CF_API_FILE}
    echo -e "${Tip} 输入的Cloudflare API信息将会存储在~/.api/cf.api"
    echo
}

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

is_cdn_proxied(){
    local IP=$1
    local ipv4_text_list=`curl -s https://www.cloudflare.com/ips-v4`
    local ipcalc_install_path="/usr/local/bin/ipcalc-0.41"
    local ipcalc_download_url="http://jodies.de/ipcalc-archive/ipcalc-0.41/ipcalc"

    if centosversion 8; then
        local ipcalcName='ipcalc'
    else
        local ipcalcName='ipcalc-0.41'

        if [ ! -e ${ipcalc_install_path} ]; then
            wget --no-check-certificate -q -c -t3 -T60 -O ${ipcalc_install_path} ${ipcalc_download_url}
            if [ $? -ne 0 ]; then
                echo -e "${Red}[Error]${suffix} Dependency package ipcalc download failed."
                exit 1
            fi
            chmod +x ${ipcalc_install_path}
            [ -f ${ipcalc_install_path} ] && ln -fs ${ipcalc_install_path} /usr/bin
        fi
    fi

    for MASK in ${ipv4_text_list[@]}
    do
        min=`$ipcalcName $MASK|awk '/HostMin:/{print $2}'`
        max=`$ipcalcName $MASK|awk '/HostMax:/{print $2}'`
        MIN=`echo $min|awk -F"." '{printf"%.0f",$1*256*256*256+$2*256*256+$3*256+$4}'`
        MAX=`echo $max|awk -F"." '{printf"%.0f",$1*256*256*256+$2*256*256+$3*256+$4}'`
        IPvalue=`echo $IP|awk -F"." '{printf"%.0f",$1*256*256*256+$2*256*256+$3*256+$4}'`
        if [ "$IPvalue" -ge "$MIN" ] && [ "$IPvalue" -le "$MAX" ]; then
            local is_exist=true
            break
        fi
    done

    if [[ ${is_exist} == true ]]; then
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
        if [[ ${libev_simple_tls} = "1" ]]; then
            echo -e "请输入一个域名(DNS-Only 或 Other)"
        elif [[ ${libev_simple_tls} = "2" ]]; then
            echo -e "请输入一个域名(CDN 或 DNS-Only 或 Other)"
        fi
        read -e -p "(默认: www.bing.com):" serverName
        [ -z "$serverName" ] && serverName="www.bing.com"
        if ! get_ip_of_domain ${serverName}; then
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
            acme_get_certificate_by_api "${serverName}"
        fi
    fi
}