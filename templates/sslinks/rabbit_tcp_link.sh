gen_ss_rabbit_tcp_link(){
    clientIpOrDomain="$(get_ip)"
    clientPluginOpts="serviceAddr=$(get_ip):${shadowsocksport};password=${rabbitKey};tunnelN=4"
    ss_plugins_client_links
}