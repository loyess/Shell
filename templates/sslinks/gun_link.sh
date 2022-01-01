gen_ss_gun_link(){
    clientIpOrDomain="${domain}"
    if [[ ${libev_gun} = "1" ]]; then
        clientPluginOpts="client"
    elif [[ ${libev_gun} = "2" ]]; then
        clientIpOrDomain="$(get_ip)"
        clientPluginOpts="client:cleartext"
    fi
    ss_plugins_client_links
}