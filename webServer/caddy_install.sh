service_caddy(){
    local caddyInitOnline=$1
    local caddyInitLocal=$2

    download_service_file ${CADDY_INIT} ${caddyInitOnline} ${caddyInitLocal}
    
    if check_sys packageManager yum; then
        chmod +x ${CADDY_INIT}
        chkconfig --add $(basename ${CADDY_INIT})
        chkconfig $(basename ${CADDY_INIT}) on
    elif check_sys packageManager apt; then
        chmod +x ${CADDY_INIT}
        update-rc.d -f $(basename ${CADDY_INIT}) defaults
    fi
}

install_caddy_v1(){
    caddy_file="caddy_linux_${ARCH}"
    caddy_url="https://dl.lamp.sh/files/caddy_linux_${ARCH}"
    download "${caddy_file}" "${caddy_url}"
    
    chmod +x ${caddy_file}
    if [ ! -e ${CADDY_INSTALL_PATH} ]; then
        mkdir -p ${CADDY_INSTALL_PATH}
    fi
    mv ${caddy_file} ${CADDY_BIN_PATH}
    [ -f ${CADDY_BIN_PATH} ] && ln -fs ${CADDY_BIN_PATH} /usr/bin

    ver_info=$(caddy -version)
    caddy_ver=$(echo $ver_info | cut -d\  -f2 | sed 's/v//g')
    caddy_ver_h1=$(echo $ver_info | cut -d\  -f3 | cut -d: -f2 | sed 's/)//g')

    echo ${caddyVerFlag},${caddy_ver} > ${CADDY_VERSION_FILE}
    echo ${caddy_ver_h1} >> ${CADDY_VERSION_FILE}
    
    service_caddy ${CADDY_INIT_ONLINE} ${CADDY_INIT_LOCAL}
    echo && echo -e " Caddy 使用命令：${CADDY_CONF_FILE}
 日志文件：/var/log/caddy-error.log | /var/log/caddy-access.log
 使用说明：service caddy start | stop | restart | status
 或者使用：/etc/init.d/caddy start | stop | restart | status
${Info} Caddy 安装完成！"
}

install_caddy_v2(){
    caddy_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/caddyserver/caddy/releases | grep -o '"tag_name": ".*"' | sed 's/"//g;s/v//g' | sed 's/tag_name: //g' | grep -E '^2' | head -n 1)
    [ -z ${caddy_ver} ] && _echo -e "获取 caddy 最新版本失败." && exit 1
    caddy_file="caddy_${caddy_ver}_linux_${ARCH}"
    caddy_url="https://github.com/caddyserver/caddy/releases/download/v${caddy_ver}/caddy_${caddy_ver}_linux_${ARCH}.tar.gz"
    download "${caddy_file}.tar.gz" "${caddy_url}"
    tar zxf "${caddy_file}.tar.gz"

    # installed clear
    rm -rf "${caddy_file}.tar.gz"
    rm -rf LICENSES.txt
    rm -rf README.txt

    chmod +x caddy
    if [ ! -e ${CADDY_INSTALL_PATH} ]; then
        mkdir -p ${CADDY_INSTALL_PATH}
    fi
    mv caddy ${CADDY_BIN_PATH}
    [ -f ${CADDY_BIN_PATH} ] && ln -fs ${CADDY_BIN_PATH} /usr/bin

    echo ${caddyVerFlag},${caddy_ver} > ${CADDY_VERSION_FILE}

    service_caddy ${CADDY_V2_INIT_ONLINE} ${CADDY_V2_INIT_LOCAL}
    echo && echo -e " Caddy 使用命令：${CADDY_CONF_FILE}
 日志文件：/var/log/caddy-access.log
 使用说明：service caddy start | stop | restart | status
 或者使用：/etc/init.d/caddy start | stop | restart | status
${Info} Caddy2 安装完成！"
}

install_caddy(){
    if [[ ${caddyVerFlag} = "1" ]]; then
        install_caddy_v1
    elif [[ ${caddyVerFlag} = "2" ]]; then
        install_caddy_v2
    fi
}
