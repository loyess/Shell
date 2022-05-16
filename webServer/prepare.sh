is_enable_web_server(){
    if [ -e "${CADDY_BIN_PATH}" ] && [ ! -e "${WEB_INSTALL_MARK}" ]; then
        _echo -i "检测到caddy已经安装：${CADDY_BIN_PATH}，跳过启用web服务器伪装设置步骤。"
        return
    elif [ -e "${NGINX_BIN_PATH}" ] && [ ! -e "${WEB_INSTALL_MARK}" ]; then
        _echo -i "检测到nginx已经安装：${NGINX_BIN_PATH}，跳过启用web服务器伪装设置步骤。"
        return
    fi

    while true
    do
        _read "是否启用web服务器伪装 (默认: n) [y/n]:"
        local yn="${inputInfo}"
        [ -z "${yn}" ] && yn="N"
        case "${yn:0:1}" in
            y|Y)
                isEnableWeb=enable
                ;;
            n|N)
                isEnableWeb=disable
                ;;
            *)
                _echo -e "输入有误，请重新输入."
                continue
                ;;
        esac
        _echo -r "  web = ${isEnableWeb}"
        break
    done
}

web_server_menu(){
    local WEB_SERVER_STYLE=(caddy nginx)

    generate_menu_logic "${WEB_SERVER_STYLE[*]}" "一个Web服务器" "1"
    web_flag="${inputInfo}"
}

choose_nginx_version_menu(){
    local NGINX_PACKAGES_V=(Stable Mainline)

    generate_menu_logic "${NGINX_PACKAGES_V[*]}" "Nginx软件包版本" "1"
    pkg_flag="${inputInfo}"
}

choose_caddy_version_menu(){
    local CADDY_PACKAGES_V=(Caddy Caddy2)

    generate_menu_logic "${CADDY_PACKAGES_V[*]}" "Caddy软件包版本" "1"
    caddyVerFlag="${inputInfo}"
}