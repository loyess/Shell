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
    kill_process "v2ray-plugin" "v2ray-plugin"
    kill_process "obfs-server" "simple-obfs"
    kill_process "kcptun-server" "kcptun"
    kill_process "gq-server" "GoQuiet"
    kill_process "ck-server" "Cloak"
    kill_process "mtt-server" "mos-tls-tunnel"
    kill_process "rabbit-tcp" "rabbit-tcp"
    kill_process "simple-tls" "simple-tls"
    kill_process "gost-plugin" "gost-plugin"
    kill_process "xray-plugin" "xray-plugin"
    kill_process "qtun-server" "qtun"
    kill_process "gun-server" "gun"
    if [ -e "${WEB_INSTALL_MARK}" ]; then
        kill_process "caddy" "caddy"
        kill_process "nginx" "nginx"
    fi
}

