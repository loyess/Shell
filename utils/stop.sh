shadowsocks_stop(){
    # kill v2ray-plugin 、obfs-server、gq-server ck-server
    ps -ef |grep -v grep | grep ss-server |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1
    ps -ef |grep -v grep | grep ssserver |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1

    if [ "$(command -v ss-server)" ]; then
        echo -e "Stopping Shadowsocks-libev success"
    fi
    
    if [ "$(command -v ssserver)" ]; then
        echo -e "Stopping Shadowsocks-rust success"
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

caddy_stop(){
    ps -ef |grep -v grep | grep caddy |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1
    
    if [ -e "${CADDY_FILE}" ]; then
        echo -e "Stopping caddy success"
    fi
}

