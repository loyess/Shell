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

get_latest_acme_sh(){
    echo -e "${Info} 升级 acme.sh 为最新的代码. "
    ~/.acme.sh/acme.sh --upgrade
}

set_defualt_ca_for_acme_sh(){
    echo -e "${Info} 设置默认 ca 为  letsencrypt."
    ~/.acme.sh/acme.sh --set-default-ca --server letsencrypt
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

count_down(){
    local seconds=${1}

    while [ $seconds -gt 0 ];do
        echo -ne ${Info} 请等待 ${seconds} 秒...
        sleep 1
        seconds=$(($seconds - 1))
        # \r 光标移至行首，但不换行
        # 相当于使用 \r 以后的字符覆盖 \r 之前同等长度的字符
        # 例如：echo -e "abcdef\r123" 输出：123def
        echo -ne "\r                         \r"
    done
}

_acme_certificate_path(){
    local domain=${1}
    local algorithmType=${2}

    if [ "${algorithmType}" == "RSA" ]; then
        cerPath="/root/.acme.sh/${domain}/fullchain.cer"
        keyPath="/root/.acme.sh/${domain}/${domain}.key"
    else
        cerPath="/root/.acme.sh/${domain}_ecc/fullchain.cer"
        keyPath="/root/.acme.sh/${domain}_ecc/${domain}.key"
    fi
}

_acme_cmd_by_force(){
    local domain=${1}
    local algorithmType=${2}

    if [ "${algorithmType}" == "RSA" ]; then
        ~/.acme.sh/acme.sh --issue -d ${domain}   --standalone
    else
        ~/.acme.sh/acme.sh --issue -d ${domain} -k ec-256 --standalone
    fi

    _acme_certificate_path "${domain}" "${algorithmType}"
}

acme_get_certificate_by_force(){
    local domain=$1
    local algorithmType=${2:-"ECC"}

    intall_acme_tool
    get_latest_acme_sh
    set_defualt_ca_for_acme_sh
            
    if [ ! "$(command -v socat)" ]; then
        echo -e "${Info} 开始安装强制生成时必要的socat 软件包."
        package_install "socat"
    fi
    
    echo
    echo -e "${Info} 开始生成域名 ${domain} 相关的证书 "
    echo

    _acme_cmd_by_force "${domain}" "${algorithmType}"

    echo
    echo -e "${Info} ${domain} 证书生成完成. "
    echo
}

_acme_cmd_by_api(){
    local domain=${1}
    local algorithmType=${2}

    if [ "${algorithmType}" == "RSA" ]; then
        ~/.acme.sh/acme.sh --issue --dns dns_cf -d ${domain}
    else
        ~/.acme.sh/acme.sh --issue --dns dns_cf -d ${domain} -k ec-256
    fi

    _acme_certificate_path "${domain}" "${algorithmType}"
}

acme_get_certificate_by_api(){
    local domain=$1
    local algorithmType=${2:-"ECC"}

    choose_api_get_mode
    intall_acme_tool
    get_latest_acme_sh
    set_defualt_ca_for_acme_sh

    echo
    echo -e "${Info} 开始生成域名 ${domain} 相关的证书 "
    echo
    export CF_Key=${CF_Key}
    export CF_Email=${CF_Email}

    _acme_cmd_by_api "${domain}" "${algorithmType}"

    echo
    echo -e "${Info} ${domain} 证书生成完成. "
    echo
}

_acme_cmd_by_manual(){
    local domain=${1}
    local algorithmType=${2}
    local isForce=${3}

    if [ "${algorithmType}" == "RSA" ]; then
        ~/.acme.sh/acme.sh --issue --dns -d ${domain} --yes-I-know-dns-manual-mode-enough-go-ahead-please ${isForce}
        if [[ $? -ne 0 && $? -ne 2 ]]; then
            echo
            echo -e "${Info} 请根据上方提示，去Cloudflare上添加txt记录，完成后按任意键开始。"
            echo -e "${Info} 如果出现“too many certificates already issued for exact set of domains”错误，请按Ctrl+C终止。"
            char=`get_char` && count_down 30
            ~/.acme.sh/acme.sh --renew -d ${domain} --yes-I-know-dns-manual-mode-enough-go-ahead-please ${isForce}
        fi
    else
        ~/.acme.sh/acme.sh --issue --dns -d ${domain} -k ec-256 --yes-I-know-dns-manual-mode-enough-go-ahead-please ${isForce}
        if [[ $? -ne 0 && $? -ne 2 ]]; then
            echo
            echo -e "${Info} 请根据上方提示，去Cloudflare上添加txt记录，完成后按任意键开始。"
            echo -e "${Info} 如果出现“too many certificates already issued for exact set of domains”错误，请按Ctrl+C终止。"
            char=`get_char` && count_down 30
            ~/.acme.sh/acme.sh --renew -d ${domain} --ecc --yes-I-know-dns-manual-mode-enough-go-ahead-please ${isForce}
        fi
    fi

    _acme_certificate_path "${domain}" "${algorithmType}"
}

acme_get_certificate_by_manual(){
    local domain=$1
    local algorithmType=${2:-"ECC"}
    local isForce=${3:-""}

    intall_acme_tool
    get_latest_acme_sh
    set_defualt_ca_for_acme_sh

    echo
    echo -e "${Info} 开始生成域名 ${domain} 相关的证书 "
    echo

    _acme_cmd_by_manual "${domain}" "${algorithmType}" "${isForce}"

    echo
    echo -e "${Info} ${domain} 证书生成完成. "
    echo
}

get_domain_ip(){
    local domain=$1
    local ipv4Re="((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])"
    
    if [ ! "$(command -v nslookup)" ]; then
        if check_sys packageManager yum; then
            package_install "bind-utils" > /dev/null 2>&1
        elif check_sys packageManager apt; then
            package_install "dnsutils" > /dev/null 2>&1
        fi
    fi

    domain_ip=`nslookup ${domain} | grep -E 'Name:' -A 1 | grep -oE $ipv4Re | tail -1`
    if [[ -n "${domain_ip}" ]]; then
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

acme_get_certificate_by_api_or_manual(){
    local domain=$1
    local algorithmType=${2:-"ECC"}
    
    get_domain_ip "${domain}"
    if echo ${domain} | grep -qE '.cf$|.ga$|.gq$|.ml$|.tk$' && is_cdn_proxied "${domain_ip}"; then
        acme_get_certificate_by_manual "${domain}" "${algorithmType}"
    else
        acme_get_certificate_by_api "${domain}" "${algorithmType}"
    fi
}

acme_get_certificate_by_manual_force(){
    local domain=$1

    local algorithmType
    local isForce="--force"

    get_domain_ip "${domain}"
    if ! (echo ${domain} | grep -qE '.cf$|.ga$|.gq$|.ml$|.tk$' && is_cdn_proxied "${domain_ip}"); then
        echo
        echo -e "${Error} 此选项为手动申请Cloudflare CDN模式 证书(有效期3个月)，仅支持后缀为.cf .ga .gq .ml .tk的域名。"
        echo
        exit 1
    fi

    if [ -d "/root/.acme.sh/${domain}" ]; then
        algorithmType="RSA"
    elif [ -d "/root/.acme.sh/${domain}_ecc" ]; then
        algorithmType="ECC"
    fi

    acme_get_certificate_by_manual "${domain}" "${algorithmType}" "${isForce}"
}
