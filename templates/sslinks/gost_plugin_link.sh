gen_ss_gost_plugin_link(){
    clientIpOrDomain="${domain}"
    if [ "${libev_gost_plugin}" = "1" ]; then
        if [ "${isEnableWeb}" = "disable" ]; then
            clientIpOrDomain="$(get_ip)"
            clientPluginOpts="path=${path};mode=${mode}${clientMux}"
        elif [ "${isEnableWeb}" = "enable" ]; then
            if [ "${mode}" = "mws" ]; then
                mode=mwss
            elif [ "${mode}" = "ws" ]; then
                mode=wss
            fi
            clientPluginOpts="serverName=${domain};host=${domain};path=${path};mode=${mode}${clientMux}"
        fi
    elif [ "${libev_gost_plugin}" = "2" ]; then
        clientPluginOpts="serverName=${domain};host=${domain};path=${path};mode=${mode}${clientMux}"
    elif [ "${libev_gost_plugin}" = "3" ]; then
        clientPluginOpts="serverName=${domain};mode=${mode}"
    elif [ "${libev_gost_plugin}" = "4" ]; then
        clientPluginOpts="serverName=${domain};mode=${mode}"
    elif [ "${libev_gost_plugin}" = "5" ]; then
        clientPluginOpts="serverName=${domain};mode=${mode}"
    elif [ "${libev_gost_plugin}" = "6" ]; then
        clientPluginOpts="serverName=${domain};mode=${mode}"
    elif [ "${libev_gost_plugin}" = "7" ]; then
        clientPluginOpts="serverName=${domain};mode=${mode}"
    fi
    ss_plugins_client_links
}