config_ss_v2ray_plugin(){
    if [ "${libev_v2ray}" = "1" ]; then
        serverPluginOpts="server;path=${path}"
    elif [ "${libev_v2ray}" = "2" ]; then
        serverPluginOpts="server;tls;host=${domain};cert=${cerPath};key=${keyPath};path=${path}"
    elif [ "${libev_v2ray}" = "3" ]; then
        serverTcpAndUdp="tcp_only"
        serverPluginOpts="server;tls;mode=quic;host=${domain};cert=${cerPath};key=${keyPath}"
    elif [ "${libev_v2ray}" = "4" ]; then
        serverPluginOpts="server;tls;mode=grpc;host=${domain};cert=${cerPath};key=${keyPath}"
    fi
    ss_plugin_server_config
    if [ "${isDisableMux}" = "disable" ]; then
        clientMux=";mux=0"
        sed 's/"plugin_opts":"/"plugin_opts":"mux=0;/' -i "${SHADOWSOCKS_CONFIG}"
    fi
}