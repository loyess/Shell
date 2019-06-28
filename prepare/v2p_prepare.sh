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
        echo -e "${Info} 证书生成工具 acme.sh 已经安装，自动进入下一步，请选择... "
        echo
    fi
}

install_prepare_libev_v2ray(){
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
    
 
    if [[ ${libev_v2ray} == "1" ]]; then
        shadowsocksport=80
        echo
        echo -e "${Tip} server_port已被重置为：port = ${shadowsocksport}"
        echo 
        
    elif [[ ${libev_v2ray} = "2" || ${libev_v2ray} = "3" ]]; then
        shadowsocksport=443
        echo
        echo -e "${Tip} server_port已被重置为：port = ${shadowsocksport}"
        echo
        
        while true
        do    
            echo
            read -e -p "请输入你的域名：" domain
            echo
            # Is the test domain correct.
            ping ${domain} -c 1 | sed '1{s/[^(]*(//;s/).*//;q}' | head -n 1 | grep -P ${IPV4_RE} > /dev/null 2>&1
            # if [[ $? -eq 0 ]] && test "$(ping ${domain} -c 1 | sed '1{s/[^(]*(//;s/).*//;q}' | head -n 1)" = $(get_ip); then
            if [[ $? -eq 0 ]]; then
                echo
                echo -e "${Red}  host = ${domain}${suffix}"
                echo
                break
            else
                echo
                echo -e "${Error} 请确认该域名是否被域名服务器成功解析，如果没有，则请在解析成功后，再次重试..."
                echo
                continue
            fi
        done

        echo 
        echo -e "是否使用CloudFlare域API自动颁发证书(否，则由acme.sh假装一个webserver, 临时监听在80 端口, 完成验证，强制生成)? [Y/n]\n" 
        read -e -p "(默认: n):" yn
        [[ -z "${yn}" ]] && yn="n"
        if [[ $yn == [Yy] ]]; then
            echo
            read -e -p "请输入你的Cloudflare的Global API Key：" CF_Key
            echo
            echo -e "${Red}  CF_Key = ${CF_Key}${suffix}"
            echo 
            read -e -p "请输入你的Cloudflare的账号Email：" CF_Email
            echo
            echo -e "${Red}  CF_Email = ${CF_Email}${suffix}"
            echo
            
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
            
        else
            intall_acme_tool
            
            if [ ! "$(command -v socat)" ]; then
                echo -e "${Info} 开始安装强制生成时必要的socat 软件包."
                if check_sys packageManager yum; then
                    yum install -y socat > /dev/null 2>&1
                    if [ $? -ne 0 ]; then
                        echo -e "${Error} 安装socat失败."
                        exit 1
                    fi
                elif check_sys packageManager apt; then
                    apt-get -y update > /dev/null 2>&1
                    apt-get -y install socat > /dev/null 2>&1
                    if [ $? -ne 0 ]; then
                        echo -e "${Error} 安装socat失败."
                        exit 1
                    fi
                fi
                echo -e "${Info} socat 安装完成."
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
        fi  

    elif [[ ${libev_v2ray} = "4" ]]; then
        while true
        do
            echo
            read -e -p "请输入你的域名(必须成功解析过本机ip)：" domain
            echo
            
            # Is the test domain correct.
            ping ${domain} -c 1 | sed '1{s/[^(]*(//;s/).*//;q}' | head -n 1 | grep -P ${IPV4_RE} > /dev/null 2>&1
            if [[ $? -eq 0 ]] && test "$(ping ${domain} -c 1 | sed '1{s/[^(]*(//;s/).*//;q}' | head -n 1 )" = $(get_ip); then
                echo
                echo -e "${Red}  host = ${domain}${suffix}"
                echo
                break
            else
                echo
                echo -e "${Error} 请确认该域名是否有解析过本机ip地址，如果没有，前往域名服务商解析本机ip地址至该域名，并重新尝试."
                echo
                continue
            fi
        done
            
            echo 
            read -e -p "请输入供于域名证书生成所需的 Email：" email
            echo
            echo -e "${Red}  email = ${email}${suffix}"
            echo
            
            echo
            read -e -p "请输入你的WebSocket分流路径(默认：/v2ray)：" path
            echo
            [ -z "${path}" ] && path="/v2ray"
            echo
            echo -e "${Red}  path = ${path}${suffix}"
            echo
            
            echo
            echo -e "${Tip} 该站点建议满足(位于海外、支持HTTPS协议、会用来传输大流量... )的条件，默认站点，随意找的，不建议使用"
            read -e -p "请输入你需要镜像到的站点(默认：https://www.bostonusa.com)：" mirror_site
            echo
            [ -z "${mirror_site}" ] && mirror_site="https://www.bostonusa.com"
            echo
            echo -e "${Red}  mirror_site = ${mirror_site}${suffix}"
            echo 

    elif [[ ${libev_v2ray} = "5" ]]; then
        while true
        do
            echo
            read -e -p "请输入你的域名(必须是交由Cloudflare域名服务器托管且成功解析过本机ip)：" domain
            echo
            
            # Is the test domain correct.
            ping ${domain} -c 1 | sed '1{s/[^(]*(//;s/).*//;q}' | head -n 1 | grep -P ${IPV4_RE} > /dev/null 2>&1
            # if [[ $? -eq 0 ]] && test "$(ping ${domain} -c 1 | sed '1{s/[^(]*(//;s/).*//;q}' | head -n 1)" = $(get_ip); then
            if [[ $? -eq 0 ]]; then
                echo
                echo -e "${Red}  host = ${domain}${suffix}"
                echo
                break
            else
                echo
                echo -e "${Error} 请确认该域名是否有交给 Cloudflare 托管，并解析过本机ip地址"
                echo -e "         如果没有，前往域名服务商将域名DNS服务器更改为 Cloudflare 的DNS服务器，并在 Cloudflare 上解析本机ip地址至该域名，并重新尝试."
                echo
                continue
            fi
        done
            
            echo
            read -e -p "请输入你的WebSocket分流路径(默认：/v2ray)：" path
            echo
            [ -z "${path}" ] && path="/v2ray"
            echo
            echo -e "${Red}  path = ${path}${suffix}"
            echo 

            echo
            echo -e "${Tip} 该站点建议满足(位于海外、支持HTTPS协议、会用来传输大流量... )的条件，默认站点，随意找的，不建议使用"
            read -e -p "请输入你需要镜像到的站点(默认：https://www.bostonusa.com)：" mirror_site
            echo
            [ -z "${mirror_site}" ] && mirror_site="https://www.bostonusa.com"
            echo
            echo -e "${Red}  mirror_site = ${mirror_site}${suffix}"
            echo 
            
            echo
            read -e -p "请输入你的Cloudflare的Global API Key：" CF_Key
            echo
            echo -e "${Red}  cloudflare_api_key = ${CF_Key}${suffix}"
            echo 
            read -e -p "请输入你的Cloudflare的账号Email：" CF_Email
            echo
            echo -e "${Red}  cloudflare_email = ${CF_Email}${suffix}"
            echo
    fi
}