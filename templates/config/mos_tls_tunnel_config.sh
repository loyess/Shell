config_ss_mos_tls_tunnel(){
    serverTcpAndUdp="tcp_only"
    if [ "${libev_mtt}" = "1" ]; then
        if [ "${doYouHaveDomian}" = "No" ]; then
            serverPluginOpts="n=${domain}"
        elif [ "${doYouHaveDomian}" = "Yes" ]; then
            serverPluginOpts="key=${keyPath};cert=${cerPath}"
        fi
    elif [ "${libev_mtt}" = "2" ]; then
        if [ "${doYouHaveDomian}" = "No" ]; then
            serverPluginOpts="wss;wss-path=${path};n=${domain}"
        elif [ "${doYouHaveDomian}" = "Yes" ]; then
            serverPluginOpts="wss;wss-path=${path};key=${keyPath};cert=${cerPath}"
        fi
    fi
    ss_plugin_server_config
    if [ "${isDisableMux}" = "enable" ]; then
        clientMux=";mux;mux-max-stream=${mux}"
        sed 's/"plugin_opts":"/"plugin_opts":"mux;/' -i "${SHADOWSOCKS_CONFIG}"
    fi
}