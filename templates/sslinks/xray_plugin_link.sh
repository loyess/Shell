gen_ss_xray_plugin_link(){
    clientIpOrDomain="${domain}"
    if [ "${libev_xray_plugin}" = "1" ]; then
        if [ "${isEnableWeb}" = "disable" ]; then
            clientIpOrDomain="$(get_ip)"
            clientPluginOpts="host=${domain};path=${path}${clientMux}"
        elif [ "${isEnableWeb}" = "enable" ]; then
            clientPluginOpts="tls;host=${domain};path=${path}${clientMux}"
        fi
    elif [ "${libev_xray_plugin}" = "2" ]; then
        clientPluginOpts="tls;host=${domain};path=${path}${clientMux}"
    elif [ "${libev_xray_plugin}" = "3" ]; then
        clientPluginOpts="tls;mode=quic;host=${domain}${clientMux}"
    elif [ "${libev_xray_plugin}" = "4" ]; then
        clientPluginOpts="tls;mode=grpc;host=${domain};serviceName=${grpcSN}${clientMux}"
    fi
    ss_plugins_client_links
}