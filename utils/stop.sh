kill_process(){
    local binaryFilePath=$1
    local projectName=$2

    ps -ef | grep -v grep | grep "${binaryFilePath}" | awk '{print $2}' | xargs kill -9 > /dev/null 2>&1

    if [ "$(command -v "${binaryFilePath}")" ]; then
        echo -e "Stopping ${projectName} success"
    fi
}

stop_services(){
    kill_process "$SHADOWSOCKS_LIBEV_BIN_PATH" "shadowsocks-libev"
    kill_process "$SHADOWSOCKS_RUST_BIN_PATH" "shadowsocks-rust"
    kill_process "$GO_SHADOWSOCKS2_BIN_PATH" "go-shadowsocks"
    kill_process "$V2RAY_PLUGIN_BIN_PATH" "v2ray-plugin"
    kill_process "$SIMPLE_OBFS_BIN_PATH" "simple-obfs"
    kill_process "$KCPTUN_BIN_PATH" "kcptun"
    kill_process "$GOQUIET_BIN_PATH" "GoQuiet"
    kill_process "$CLOAK_SERVER_BIN_PATH" "Cloak"
    kill_process "$MTT_BIN_PATH" "mos-tls-tunnel"
    kill_process "$RABBIT_BIN_PATH" "rabbit-tcp"
    kill_process "$SIMPLE_TLS_BIN_PATH" "simple-tls"
    kill_process "$GOST_PLUGIN_BIN_PATH" "gost-plugin"
    kill_process "$XRAY_PLUGIN_BIN_PATH" "xray-plugin"
    kill_process "$QTUN_BIN_PATH" "qtun"
    kill_process "$GUN_BIN_PATH" "gun"
    if [ -e "${WEB_INSTALL_MARK}" ]; then
        kill_process "$CADDY_BIN_PATH" "caddy"
        kill_process "$NGINX_BIN_PATH" "nginx"
    fi
}

