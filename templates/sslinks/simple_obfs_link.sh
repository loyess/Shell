gen_ss_simple_obfs_link(){
    clientIpOrDomain="$(get_ip)"
    clientPluginOpts="obfs=${shadowsocklibev_obfs};obfs-host=${domain}"
    ss_plugins_client_links
}