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

transport_mode_menu(){
    while true
    do
        echo -e "请为v2ray-plugin选择 Transport mode\n"
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

get_domain_ip(){
    domain_ip=`ping ${domain} -c 1 2>nul | sed '1{s/[^(]*(//;s/).*//;q}'`
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
    
    if [ ! -e ${ipcalc_install_path} ]; then
        wget --no-check-certificate -q -c -t3 -T60 -O ${ipcalc_install_path} ${ipcalc_download_url}
        if [ $? -ne 0 ]; then
            echo -e "${Red}[Error]${suffix} Dependency package ipcalc download failed."
            exit 1
        fi
        chmod +x ${ipcalc_install_path}
    fi

    for MASK in ${ipv4_text_list[@]}
    do
        min=`ipcalc-0.41 $MASK|awk '/HostMin:/{print $2}'`
        max=`ipcalc-0.41 $MASK|awk '/HostMax:/{print $2}'`
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

choose_api_get_mode(){
    if [[ ! -e ~/.api/cf.api ]]; then
        get_input_api_info
    else
        echo
        echo -e "检测到${Green}~/.api/cf.api${suffix}文件存在，开始获取API信息."
        CF_Email=$(cat ~/.api/cf.api | grep "CLOUDFLARE_EMAIL" | cut -d= -f2)
        CF_Key=$(cat ~/.api/cf.api | grep "CLOUDFLARE_API_KEY" | cut -d= -f2)
        echo
        echo -e "${Red}  CF_Key = ${CF_Key}${suffix}"
        echo -e "${Red}  CF_Email = ${CF_Email}${suffix}"
        echo 
    fi
}

acme_get_certificate_by_api(){
    choose_api_get_mode
    intall_acme_tool
    
    echo
    echo -e "${Info} 开始生成域名 ${domain} 相关的证书 "
    echo
    export CF_Key=${CF_Key}
    export CF_Email=${CF_Email}
    ~/.acme.sh/acme.sh --issue --dns dns_cf -d ${domain}
    
    cerpath="/root/.acme.sh/${domain}/fullchain.cer"
    keypath="/root/.acme.sh/${domain}/${domain}.key"
    
    echo
    echo -e "${Info} ${domain} 证书生成完成. "
    echo
}

acme_get_certificate_by_force(){
    intall_acme_tool
            
    if [ ! "$(command -v socat)" ]; then
        echo -e "${Info} 开始安装强制生成时必要的socat 软件包."
        package_install "socat"
    fi
    
    echo
    echo -e "${Info} 开始生成域名 ${domain} 相关的证书 "
    echo
    ~/.acme.sh/acme.sh --issue -d ${domain}   --standalone
    
    cerpath="/root/.acme.sh/${domain}/fullchain.cer"
    keypath="/root/.acme.sh/${domain}/${domain}.key"
    
    echo
    echo -e "${Info} ${domain} 证书生成完成. "
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

get_input_email_for_caddy(){
    echo 
    read -e -p "请输入供于域名证书生成所需的 Email：" email
    echo
    echo -e "${Red}  email = ${email}${suffix}"
    echo
    
}

get_input_api_info(){
    echo
    read -e -p "请输入你的Cloudflare的Global API Key：" CF_Key
    echo
    echo
    echo -e "${Red}  CF_Key = ${CF_Key}${suffix}"
    echo 
    read -e -p "请输入你的Cloudflare的账号Email：" CF_Email
    echo
    echo -e "${Red}  CF_Email = ${CF_Email}${suffix}"
    echo
    if [[ ! -e ~/.api ]]; then
        mkdir -p ~/.api
    fi
    local CF_API_FILE=~/.api/cf.api
    echo "CLOUDFLARE_EMAIL=${CF_Email}" > ${CF_API_FILE}
    echo "CLOUDFLARE_API_KEY=${CF_Key}" >> ${CF_API_FILE}
    echo -e "${Tip} 输入的Cloudflare API信息将会存储在~/.api/cf.api"
    echo
}

get_input_ws_path_and_mirror_site(){
    echo
    read -e -p "请输入你的WebSocket分流路径(默认：/v2ray)：" path
    echo
    [ -z "${path}" ] && path="/v2ray"
    echo -e "${Red}  path = ${path}${suffix}"
    echo
    
    echo
    echo -e "${Tip} 该站点建议满足(位于海外、支持HTTPS协议、会用来传输大流量... )的条件，默认站点，随意找的，不建议使用"
    read -e -p "请输入你需要镜像到的站点(默认：https://www.bostonusa.com)：" mirror_site
    echo
    [ -z "${mirror_site}" ] && mirror_site="https://www.bostonusa.com"
    echo -e "${Red}  mirror_site = ${mirror_site}${suffix}"
    echo
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
    
 
    if [[ ${libev_v2ray} == "1" ]]; then
        if check_port_occupy "80"; then
            echo -e "${Error} 检测到80端口被占用，请排查后重新运行." && exit 1
        fi
        v2ray_plugin_prot_reset 80
        
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
                acme_get_certificate_by_api
                break
            elif is_dns_only ${domain_ip}; then
                acme_get_certificate_by_force
                break
            else
                print_error_info ${TEXT2}
                continue
            fi
        done 
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
                get_input_email_for_caddy
                get_input_ws_path_and_mirror_site
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
                choose_api_get_mode
                get_input_ws_path_and_mirror_site
                break
            else
                print_error_info ${TEXT4}
                continue
            fi
        done
    fi
}