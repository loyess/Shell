gen_ss_mos_tls_tunnel_link(){
    clientIpOrDomain="$(get_ip)"
    if [ "${libev_mtt}" = "1" ]; then
        if [ "${doYouHaveDomian}" = "No" ]; then
            clientPluginOpts="sv;n=${domain}${clientMux}"
        elif [ "${doYouHaveDomian}" = "Yes" ]; then
            clientPluginOpts="n=${domain}${clientMux}"
        fi
    elif [ "${libev_mtt}" = "2" ]; then
        if [ "${doYouHaveDomian}" = "No" ]; then
            clientPluginOpts="sv;wss;wss-path=${path};n=${domain}${clientMux}"
        elif [ "${doYouHaveDomian}" = "Yes" ]; then
            clientPluginOpts="wss;wss-path=${path};n=${domain}${clientMux}"
        fi
    fi
    ss_plugins_client_links
}