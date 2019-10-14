service_caddy(){
    download_service_file ${CADDY_INIT} ${ONLINE_CADDY_CENTOS_INIT_URL} ${LOCAL_CADDY_DEBIAN_INIT_PATH} ${ONLINE_CADDY_DEBIAN_INIT_URL} ${LOCAL_CADDY_DEBIAN_INIT_PATH}
    
    if check_sys packageManager yum; then
        chmod +x ${CADDY_INIT}
		chkconfig --add $(basename ${CADDY_INIT})
		chkconfig $(basename ${CADDY_INIT}) on
    elif check_sys packageManager apt; then
        chmod +x ${CADDY_INIT}
		update-rc.d -f $(basename ${CADDY_INIT}) defaults
    fi
}

install_caddy(){
    local extension=$1
    
    if [[ ! -z ${extension} ]]; then
		extension_all="?plugins=${extension}&license=personal"
	else
		extension_all="?license=personal"
	fi
    
    download "caddy_linux.tar.gz" "https://caddyserver.com/download/linux/amd64${extension_all}"
    tar zxf "caddy_linux.tar.gz"
    
    # installed clear
	rm -rf "caddy_linux.tar.gz"
    rm -rf LICENSES.txt
	rm -rf README.txt 
	rm -rf CHANGES.txt
	rm -rf "init/"
    
	chmod +x caddy
    if [ ! -e "$(dirname ${CADDY_FILE})" ]; then
        mkdir -p $(dirname ${CADDY_FILE})
    fi
    mv caddy ${CADDY_FILE}
    [ -f ${CADDY_FILE} ] && ln -fs ${CADDY_FILE} /usr/bin
    
    service_caddy
    echo && echo -e " Caddy 使用命令：${CADDY_CONF_FILE}
 日志文件：cat /tmp/caddy.log
 使用说明：service caddy start | stop | restart | status
 或者使用：/etc/init.d/caddy start | stop | restart | status
${Info} Caddy 安装完成！"
}

uninstall_caddy(){
	if [[ -e ${CADDY_FILE} ]]; then
        PID=`ps -ef |grep "caddy" |grep -v "grep" |grep -v "init.d" |grep -v "service" |grep -v "caddy_install" |awk '{print $2}'`
        [[ ! -z ${PID} ]] && kill -9 ${PID}
        if check_sys packageManager yum; then
            chkconfig --del caddy
        elif check_sys packageManager apt; then
            update-rc.d -f caddy remove
        fi
        [[ -s /tmp/caddy.log ]] && rm -rf /tmp/caddy.log
        rm -rf $(dirname ${CADDY_FILE})
        rm -rf /etc/init.d/caddy
        rm -rf /usr/bin/caddy
    fi
}

