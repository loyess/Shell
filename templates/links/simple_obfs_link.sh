# ss + simple-obfs link
ss_obfs_http_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@$(get_ip):${shadowsocksport}/?plugin=${plugin_client_name}"    
    local plugin_opts=$(get_str_replace ";obfs=${shadowsocklibev_obfs}")
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

ss_obfs_tls_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@$(get_ip):${shadowsocksport}/?plugin=${plugin_client_name}"    
    local plugin_opts=$(get_str_replace ";obfs=${shadowsocklibev_obfs}")
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

gen_ss_simple_obfs_link(){
    if [[ ${libev_obfs} == "1" ]]; then
       ss_obfs_http_link
    elif [[ ${libev_obfs} == "2" ]]; then    
       ss_obfs_tls_link
    fi
}