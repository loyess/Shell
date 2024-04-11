gen_ss_v2ray_plugin_link(){
    clientIpOrDomain="${domain}"
    if [ "${libev_v2ray}" = "1" ]; then
        if [ "${isEnableWeb}" = "disable" ]; then
            clientIpOrDomain="$(get_ip)"
            clientPluginOpts="host=${domain};path=${path}${clientMux}"
        elif [ "${isEnableWeb}" = "enable" ]; then
            clientPluginOpts="tls;host=${domain};path=${path}${clientMux}"
        fi
    elif [ "${libev_v2ray}" = "2" ]; then
        clientPluginOpts="tls;host=${domain};path=${path}${clientMux}"
    elif [ "${libev_v2ray}" = "3" ]; then
        clientPluginOpts="tls;mode=quic;host=${domain}${clientMux}"
    elif [ "${libev_v2ray}" = "4" ]; then
        clientPluginOpts="tls;mode=grpc;host=${domain};serviceName=${grpcSN}${clientMux}"
    fi
    ss_plugins_client_links
}