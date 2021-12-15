check_running() {
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

    # PID exists. PidFile does not exist. delete PidFile
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
    if check_running ${PID_FILE}; then
        echo "$NAME (pid $PID) is already running."
        return 0
    fi

    # Save PID into PidFile
    echo ${PLUGIN_PID} > ${PID_FILE}

    # Check starting
    if check_running ${PID_FILE}; then
        echo "Starting $NAME success"
    else
        echo "Starting $NAME failed"
    fi
}

shadowsocks_start(){
    if [[ "$(command -v ss-server)" ]]; then
        ${SHADOWSOCKS_LIBEV_INIT} start
    fi
    
    if [[ "$(command -v ssserver)" ]]; then
        ${SHADOWSOCKS_RUST_INIT} start
    fi

    if [[ "$(command -v go-shadowsocks2)" ]]; then
        ${GO_SHADOWSOCKS2_INIT} start
    fi
}

v2ray_plugin_start(){
    if [ "$(command -v v2ray-plugin)" ]; then
        local NAME="v2ray-plugin"
        local PID=`ps -ef |grep -Ev 'grep|-plugin-opts' | grep v2ray-plugin |awk '{print $2}'`

        sip003_plugin_start "${NAME}" "${PID}"
    fi
        
        
}

kcptun_start(){
    if [ "$(command -v kcptun-server)" ]; then
        ${KCPTUN_INIT} start
    fi
}

simple_obfs_start(){
    if [ "$(command -v obfs-server)" ]; then
        local NAME="simple-obfs"
        local PID=`ps -ef |grep -Ev 'grep|-plugin-opts' | grep obfs-server |awk '{print $2}'`

        sip003_plugin_start "${NAME}" "${PID}"
    fi
}

goquiet_start(){
    if [ "$(command -v gq-server)" ]; then
        local NAME="goquiet"
        local PID=`ps -ef |grep -Ev 'grep|-plugin-opts' | grep gq-server |awk '{print $2}'`

        sip003_plugin_start "${NAME}" "${PID}"
    fi
}

cloak_start(){
    if [[ -e "${CLOAK_INIT}" ]]; then
        /etc/init.d/cloak start
    fi
}

mtt_start(){
    if [ "$(command -v mtt-server)" ]; then
        local NAME="mos-tls-tunnel"
        local PID=`ps -ef |grep -Ev 'grep|-plugin-opts' | grep mtt-server |awk '{print $2}'`

        sip003_plugin_start "${NAME}" "${PID}"
    fi
}

rabbit_tcp_start(){
    if [[ -e "${RABBIT_INIT}" ]]; then
        /etc/init.d/rabbit-tcp start
    fi
}

simple_tls_start(){
    if [ "$(command -v simple-tls)" ]; then
        local NAME="simple-tls"
        local PID=`ps -ef |grep -Ev 'grep|-plugin-opts' | grep simple-tls |awk '{print $2}'`

        sip003_plugin_start "${NAME}" "${PID}"
    fi
}

gost_plugin_start(){
    if [ "$(command -v gost-plugin)" ]; then
        local NAME="gost-plugin"
        local PID=`ps -ef |grep -Ev 'grep|-plugin-opts' | grep gost-plugin |awk '{print $2}'`

        sip003_plugin_start "${NAME}" "${PID}"
    fi
}

xray_plugin_start(){
    if [ "$(command -v xray-plugin)" ]; then
        local NAME="xray-plugin"
        local PID=`ps -ef |grep -Ev 'grep|-plugin-opts' | grep xray-plugin |awk '{print $2}'`

        sip003_plugin_start "${NAME}" "${PID}"
    fi
}

qtun_start(){
    if [ "$(command -v qtun-server)" ]; then
        local NAME="qtun"
        local PID=`ps -ef |grep -Ev 'grep|-plugin-opts' | grep qtun-server |awk '{print $2}'`

        sip003_plugin_start "${NAME}" "${PID}"
    fi
}

caddy_start(){
    if [ -e "${CADDY_BIN_PATH}" ]; then
        /etc/init.d/caddy start
    fi  
}

nginx_start(){
    if [ -e "${NGINX_BIN_PATH}" ]; then
        systemctl start nginx
        
        if $(systemctl status nginx | grep -q '\(running\)'); then 
            echo "Starting nginx success"
        else
            echo "Starting nginx failed"
        fi
    fi
}

start_services(){
    shadowsocks_start
    sleep 0.1
    v2ray_plugin_start
    kcptun_start
    simple_obfs_start
    goquiet_start
    cloak_start
    mtt_start
    rabbit_tcp_start
    simple_tls_start
    gost_plugin_start
    xray_plugin_start
    qtun_start
    caddy_start
    nginx_start
}





