_check_running() {
    local PID_FILE=$1
    
    if [ ! -e $PID_FILE ]; then
        return 2
    fi
    
    read PID < $PID_FILE
    if [ -d "/proc/$PID" ]; then
        return 0
    else
        rm -f $PID_FILE
        return 1
    fi
}

sip003_plugin_start(){
    local NAME=$1
    local PLUGIN_PID=$2
    local PID_DIR=/var/run
    local PID_FILE=$PID_DIR/$NAME.pid

    # PidFile exists. PID does not exist. delete PidFile
    if [ -z ${PLUGIN_PID} ]; then
        if [ -e ${PID_FILE} ]; then
            rm -f ${PID_FILE}
        fi
    fi

    # Create PidDir
    if [ ! -d ${PID_DIR} ]; then
        mkdir -p ${PID_DIR}
        if [ $? -ne 0 ]; then
            echo "Creating PID directory $PID_DIR failed"
            exit 1
        fi
    fi

    # Check already running
    if _check_running ${PID_FILE}; then
        echo "$NAME (pid $PID) is already running."
        return 0
    fi

    # Save PID into PidFile
    echo ${PLUGIN_PID} > ${PID_FILE}

    # Check starting
    if _check_running ${PID_FILE}; then
        echo "Starting $NAME success"
    else
        echo "Starting $NAME failed"
    fi
}

initd_file_start(){
    local binaryName=$1
    local initdFilePath=$2
    
    if [ "$(command -v "${binaryName}")" ]; then
        ${initdFilePath} start
    fi
}

sip003_way_start(){
    local binaryName=$1
    local projectName=$2
    local processPid

    if [ "$(command -v "${binaryName}")" ]; then
        processPid=`ps -ef | grep -Ev 'grep|-plugin-opts' | grep "${binaryName}" | awk '{print $2}'`
        sip003_plugin_start "${projectName}" "${processPid}"
    fi
}

nginx_start(){
    if [ -e "${NGINX_BIN_PATH}" ] && [ -e "${WEB_INSTALL_MARK}" ]; then
        systemctl start nginx
        
        if $(systemctl status nginx | grep -q '\(running\)'); then 
            echo "Starting nginx success"
        else
            echo "Starting nginx failed"
        fi
    fi
}

start_services(){
    initd_file_start "ss-server" "${SHADOWSOCKS_LIBEV_INIT}"
    initd_file_start "ssservice" "${SHADOWSOCKS_RUST_INIT}"
    initd_file_start "go-shadowsocks2" "${GO_SHADOWSOCKS2_INIT}"
    initd_file_start "kcptun-server" "${KCPTUN_INIT}"
    initd_file_start "ck-server" "${CLOAK_INIT}"
    initd_file_start "rabbit-tcp" "${RABBIT_INIT}"
    if [ -e "${WEB_INSTALL_MARK}" ]; then
        initd_file_start "caddy" "${CADDY_INIT}"
    fi
    sip003_way_start "v2ray-plugin" "v2ray-plugin"
    sip003_way_start "obfs-server" "simple-obfs"
    sip003_way_start "gq-server" "GoQuiet"
    sip003_way_start "mtt-server" "mos-tls-tunnel"
    sip003_way_start "simple-tls" "simple-tls"
    sip003_way_start "gost-plugin" "gost-plugin"
    sip003_way_start "xray-plugin" "xray-plugin"
    sip003_way_start "qtun-server" "qtun"
    sip003_way_start "gun-server" "gun"
    nginx_start
}





