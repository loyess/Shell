config_ss_xray_plugin(){
    if [ "${libev_xray_plugin}" = "1" ]; then
        serverPluginOpts="server;host=${domain};path=${path}"
    elif [ "${libev_xray_plugin}" = "2" ]; then
        serverPluginOpts="server;tls;host=${domain};cert=${cerPath};key=${keyPath};path=${path}"
    elif [ "${libev_xray_plugin}" = "3" ]; then
        serverTcpAndUdp="tcp_only"
        serverPluginOpts="server;tls;mode=quic;host=${domain};cert=${cerPath};key=${keyPath}"
    elif [ "${libev_xray_plugin}" = "4" ]; then
        serverPluginOpts="server;tls;mode=grpc;host=${domain};cert=${cerPath};key=${keyPath}"
    fi
    ss_plugin_server_config
    if [ "${isDisableMux}" = "disable" ]; then
        clientMux=";mux=0"
        sed 's/"plugin_opts":"/"plugin_opts":"mux=0;/' -i "${SHADOWSOCKS_CONFIG}"
    fi
}