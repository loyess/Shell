# ss + gun link
ss_gun_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@${domain}:${shadowsocksport}/?plugin=${plugin_client_name}"
    local plugin_opts=$(get_str_replace ";${clientGunPluginOpts}")
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

gen_ss_gun_link(){
    if [[ ${libev_gun} = "1" ]]; then
        clientGunPluginOpts="client"
    elif [[ ${libev_gun} = "2" ]]; then
        domain="$(get_ip)"
        clientGunPluginOpts="client:cleartext"
    fi
    ss_gun_link
}