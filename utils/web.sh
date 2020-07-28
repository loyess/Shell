is_enable_web_server(){
    while true
    do
        echo
        echo -e "是否启用web服务器伪装"
        read -p "(默认: n) [y/n]: " yn
        [ -z "${yn}" ] && yn="N"
        case "${yn:0:1}" in
            y|Y)
                isEnableWeb=enable
                ;;
            n|N)
                isEnableWeb=disable
                ;;
            *)
                echo
                echo -e "${Error} 输入有误，请重新输入!"
                echo
                continue
                ;;
        esac

        echo
        echo -e "${Red}  web = ${isEnableWeb}${suffix}"
        echo
        break
    done
}

web_server_menu(){
    local WEB_SERVER_STYLE=(caddy nginx)

    while true
    do
        echo -e "请选择一个Web服务器\n"
        for ((i=1;i<=${#WEB_SERVER_STYLE[@]};i++)); do
            hint="${WEB_SERVER_STYLE[$i-1]}"
            echo -e "${Green}  ${i}.${suffix} ${hint}"
        done
        echo
        read -e -p "(默认：${WEB_SERVER_STYLE[0]}):" web_flag
        [ -z "$web_flag" ] && web_flag=1
        expr ${web_flag} + 1 &>/dev/null
        if [ $? -ne 0 ]; then
            echo
            echo -e "${Error} 请输入一个数字"
            echo
            continue
        fi
        if [[ "$web_flag" -lt 1 || "$web_flag" -gt ${#WEB_SERVER_STYLE[@]} ]]; then
            echo
            echo -e "${Error} 请输入一个数字在 [1-${#WEB_SERVER_STYLE[@]}] 之间"
            echo
            continue
        fi

        web_server=${WEB_SERVER_STYLE[$web_flag-1]}
        echo
        echo -e "${Red}  web = ${web_server}${suffix}"
        echo

        break
    done
}

choose_nginx_version_menu(){
    local NGINX_PACKAGES_V=(Stable Mainline)

    while true
    do
        echo -e "请选择Nginx软件包版本\n"
        for ((i=1;i<=${#NGINX_PACKAGES_V[@]};i++)); do
            hint="${NGINX_PACKAGES_V[$i-1]}"
            echo -e "${Green}  ${i}.${suffix} ${hint}"
        done
        echo
        read -e -p "(默认：${NGINX_PACKAGES_V[0]}):" pkg_flag
        [ -z "$pkg_flag" ] && pkg_flag=1
        expr ${pkg_flag} + 1 &>/dev/null
        if [ $? -ne 0 ]; then
            echo
            echo -e "${Error} 请输入一个数字"
            echo
            continue
        fi
        if [[ "$pkg_flag" -lt 1 || "$pkg_flag" -gt ${#NGINX_PACKAGES_V[@]} ]]; then
            echo
            echo -e "${Error} 请输入一个数字在 [1-${#NGINX_PACKAGES_V[@]}] 之间"
            echo
            continue
        fi

        echo
        echo -e "${Red}  version = ${NGINX_PACKAGES_V[$pkg_flag-1]}${suffix}"
        echo

        break
    done
}

choose_caddy_version_menu(){
    local CADDY_PACKAGES_V=(Caddy Caddy2)

    while true
    do
        echo -e "请选择Caddy软件包版本\n"
        for ((i=1;i<=${#CADDY_PACKAGES_V[@]};i++)); do
            hint="${CADDY_PACKAGES_V[$i-1]}"
            echo -e "${Green}  ${i}.${suffix} ${hint}"
        done
        echo
        read -e -p "(默认：${CADDY_PACKAGES_V[0]}):" caddyVerFlag
        [ -z "$caddyVerFlag" ] && caddyVerFlag=1
        expr ${caddyVerFlag} + 1 &>/dev/null
        if [ $? -ne 0 ]; then
            echo
            echo -e "${Error} 请输入一个数字"
            echo
            continue
        fi
        if [[ "$caddyVerFlag" -lt 1 || "$caddyVerFlag" -gt ${#CADDY_PACKAGES_V[@]} ]]; then
            echo
            echo -e "${Error} 请输入一个数字在 [1-${#CADDY_PACKAGES_V[@]}] 之间"
            echo
            continue
        fi

        echo
        echo -e "${Red}  version = ${CADDY_PACKAGES_V[$caddyVerFlag-1]}${suffix}"
        echo

        break
    done
}