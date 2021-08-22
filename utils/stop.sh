shadowsocks_stop(){
    # kill v2ray-plugin 、obfs-server、gq-server ck-server
    ps -ef |grep -v grep | grep ss-server |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1
    ps -ef |grep -v grep | grep ssserver |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1
    ps -ef |grep -v grep | grep go-shadowsocks2 |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1

    if [ "$(command -v ss-server)" ]; then
        echo -e "Stopping Shadowsocks-libev success"
    fi
    
    if [ "$(command -v ssserver)" ]; then
        echo -e "Stopping Shadowsocks-rust success"
    fi

    if [ "$(command -v go-shadowsocks2)" ]; then
        echo -e "Stopping Go-shadowsocks success"
    fi
}

v2ray_plugin_stop(){
    ps -ef |grep -v grep | grep v2ray-plugin |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1

    if [ "$(command -v v2ray-plugin)" ]; then
        rm -f /var/run/v2ray-plugin.pid
        echo -e "Stopping v2ray-plugin success"
    fi
}

kcptun_stop(){
    ps -ef |grep -v grep | grep kcptun-server |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1

    if [ "$(command -v kcptun-server)" ]; then
        echo -e "Stopping kcptun-server success"
    fi
}

simple_obfs_stop(){
    ps -ef |grep -v grep | grep obfs-server |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1

    if [ "$(command -v obfs-server)" ]; then
        rm -f /var/run/simple-obfs.pid
        echo -e "Stopping obfs-server success"
    fi
}

goquiet_stop(){
    ps -ef |grep -v grep | grep gq-server |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1

    if [ "$(command -v gq-server)" ]; then
        rm -f /var/run/goquiet.pid
        echo -e "Stopping gq-server success"
    fi
}

cloak_stop(){
    ps -ef |grep -v grep | grep ck-server |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1

    if [ "$(command -v ck-server)" ]; then
        echo -e "Stopping ck-server success"
    fi
}

mtt_stop(){
    ps -ef |grep -v grep | grep mtt-server |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1

    if [ "$(command -v mtt-server)" ]; then
        rm -f /var/run/mos-tls-tunnel.pid
        echo -e "Stopping mtt-server success"
    fi
}

rabbit_tcp_stop(){
    ps -ef |grep -v grep | grep rabbit-tcp |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1

    if [ "$(command -v rabbit-tcp)" ]; then
        echo -e "Stopping rabbit-tcp success"
    fi
}

simple_tls_stop(){
    ps -ef |grep -v grep | grep simple-tls |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1

    if [ "$(command -v simple-tls)" ]; then
        echo -e "Stopping simple-tls success"
    fi
}

gost_plugin_stop(){
    ps -ef |grep -v grep | grep gost-plugin |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1

    if [ "$(command -v gost-plugin)" ]; then
        echo -e "Stopping gost-plugin success"
    fi
}

xray_plugin_stop(){
    ps -ef |grep -v grep | grep xray-plugin |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1

    if [ "$(command -v xray-plugin)" ]; then
        echo -e "Stopping xray-plugin success"
    fi
}

caddy_stop(){
    ps -ef |grep -v grep | grep caddy |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1
    
    if [ -e "${CADDY_BIN_PATH}" ]; then
        echo -e "Stopping caddy success"
    fi
}

nginx_stop(){
    if [ -e "${NGINX_BIN_PATH}" ]; then
        systemctl stop nginx
        
        if $(systemctl status nginx | grep -q '\(dead\)'); then 
            echo "Stopping nginx success"
        else
            echo "Stopping nginx failed"
        fi
    fi
}

stop_services(){
    shadowsocks_stop
    v2ray_plugin_stop
    kcptun_stop
    simple_obfs_stop
    goquiet_stop
    cloak_stop
    mtt_stop
    rabbit_tcp_stop
    simple_tls_stop
    gost_plugin_stop
    xray_plugin_stop
    caddy_stop
    nginx_stop
}

