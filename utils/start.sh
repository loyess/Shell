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

shadowsocks_start(){
    if [[ "$(command -v ss-server)" ]]; then
        ${SHADOWSOCKS_LIBEV_INIT} start
    fi
    
    if [[ "$(command -v ssserver)" ]]; then
        ${SHADOWSOCKS_RUST_INIT} start
    fi
}

v2ray_plugin_start(){
    if [ "$(command -v v2ray-plugin)" ]; then
        local NAME="v2ray-plugin"
        local PID_DIR=/var/run
        local PID_FILE=$PID_DIR/$NAME.pid
        local V2_PID=`ps -ef |grep -v grep | grep v2ray-plugin |awk '{print $2}'`
        
        if [ -z ${V2_PID} ]; then
            if [ -e ${PID_FILE} ]; then
                rm -f ${PID_FILE}
            fi
        fi

        if [ ! -d ${PID_DIR} ]; then
            mkdir -p ${PID_DIR}
            if [ $? -ne 0 ]; then
                echo "Creating PID directory $PID_DIR failed"
                exit 1
            fi
        fi
        
        if check_running ${PID_FILE}; then
            echo "$NAME (pid $PID) is already running."
            return 0
        fi
        
        echo ${V2_PID} > ${PID_FILE}
        
        if check_running ${PID_FILE}; then
            echo "Starting $NAME success"
        else
            echo "Starting $NAME failed"
        fi
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
        local PID_DIR=/var/run
        local PID_FILE=$PID_DIR/$NAME.pid
        local OBFS_PID=`ps -ef |grep -v grep | grep obfs-server |awk '{print $2}'`
        
        if [ -z ${OBFS_PID} ]; then
            if [ -e ${PID_FILE} ]; then
                rm -f ${PID_FILE}
            fi
        fi

        if [ ! -d ${PID_DIR} ]; then
            mkdir -p ${PID_DIR}
            if [ $? -ne 0 ]; then
                echo "Creating PID directory $PID_DIR failed"
                exit 1
            fi
        fi
        
        if check_running ${PID_FILE}; then
            echo "$NAME (pid $PID) is already running."
            return 0
        fi
        
        echo ${OBFS_PID} > ${PID_FILE}
        
        if check_running ${PID_FILE}; then
            echo "Starting $NAME success"
        else
            echo "Starting $NAME failed"
        fi    
    fi
}

goquiet_start(){
    if [ "$(command -v gq-server)" ]; then
        local NAME="goquiet"
        local PID_DIR=/var/run
        local PID_FILE=$PID_DIR/$NAME.pid
        local GQ_PID=`ps -ef |grep -v grep | grep gq-server |awk '{print $2}'`
        
        if [ -z ${GQ_PID} ]; then
            if [ -e ${PID_FILE} ]; then
                rm -f ${PID_FILE}
            fi
        fi

        if [ ! -d ${PID_DIR} ]; then
            mkdir -p ${PID_DIR}
            if [ $? -ne 0 ]; then
                echo "Creating PID directory $PID_DIR failed"
                exit 1
            fi
        fi
        
        if check_running ${PID_FILE}; then
            echo "$NAME (pid $PID) is already running."
            return 0
        fi
        
        echo ${GQ_PID} > ${PID_FILE}
        
        if check_running ${PID_FILE}; then
            echo "Starting $NAME success"
        else
            echo "Starting $NAME failed"
        fi    
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
        local PID_DIR=/var/run
        local PID_FILE=$PID_DIR/$NAME.pid
        local MTT_PID=`ps -ef |grep -v grep | grep mtt-server |awk '{print $2}'`
        
        if [ -z ${MTT_PID} ]; then
            if [ -e ${PID_FILE} ]; then
                rm -f ${PID_FILE}
            fi
        fi

        if [ ! -d ${PID_DIR} ]; then
            mkdir -p ${PID_DIR}
            if [ $? -ne 0 ]; then
                echo "Creating PID directory $PID_DIR failed"
                exit 1
            fi
        fi
        
        if check_running ${PID_FILE}; then
            echo "$NAME (pid $PID) is already running."
            return 0
        fi
        
        echo ${MTT_PID} > ${PID_FILE}
        
        if check_running ${PID_FILE}; then
            echo "Starting $NAME success"
        else
            echo "Starting $NAME failed"
        fi    
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
        local PID_DIR=/var/run
        local PID_FILE=$PID_DIR/$NAME.pid
        local SIMPLE_TLS_PID=`ps -ef |grep -v grep | grep simple-tls |awk '{print $2}'`

        if [ -z ${SIMPLE_TLS_PID} ]; then
            if [ -e ${PID_FILE} ]; then
                rm -f ${PID_FILE}
            fi
        fi

        if [ ! -d ${PID_DIR} ]; then
            mkdir -p ${PID_DIR}
            if [ $? -ne 0 ]; then
                echo "Creating PID directory $PID_DIR failed"
                exit 1
            fi
        fi

        if check_running ${PID_FILE}; then
            echo "$NAME (pid $PID) is already running."
            return 0
        fi

        echo ${SIMPLE_TLS_PID} > ${PID_FILE}

        if check_running ${PID_FILE}; then
            echo "Starting $NAME success"
        else
            echo "Starting $NAME failed"
        fi
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
    caddy_start
    nginx_start
}





