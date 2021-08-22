# ss + v2ray-plugin link
ss_v2ray_ws_http_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@$(get_ip):${shadowsocksport}/?plugin=${plugin_client_name}"
    local plugin_opts=$(get_str_replace ";host=${domain};path=${path};mux=${mux}")
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

ss_v2ray_ws_tls_cdn_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@${domain}:${shadowsocksport}/?plugin=${plugin_client_name}"
    local plugin_opts=$(get_str_replace ";tls;host=${domain};path=${path};mux=${mux}")
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

ss_v2ray_quic_tls_cdn_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@${domain}:${shadowsocksport}/?plugin=${plugin_client_name}"
    local plugin_opts=$(get_str_replace ";mode=quic;host=${domain}")
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

ss_v2ray_ws_tls_web_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@${domain}:443/?plugin=${plugin_client_name}"    
    local plugin_opts=$(get_str_replace ";tls;host=${domain};path=${path};mux=${mux}")
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

ss_v2ray_ws_tls_web_cdn_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@${domain}:443/?plugin=${plugin_client_name}"    
    local plugin_opts=$(get_str_replace ";tls;host=${domain};path=${path};mux=${mux}")
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

gen_ss_v2ray_plugin_link(){
    if [[ ${libev_v2ray} == "1" ]]; then
        ss_v2ray_ws_http_link
    elif [[ ${libev_v2ray} == "2" ]]; then
        ss_v2ray_ws_tls_cdn_link
    elif [[ ${libev_v2ray} == "3" ]]; then
        ss_v2ray_quic_tls_cdn_link
    elif [[ ${libev_v2ray} == "4" ]]; then
        ss_v2ray_ws_tls_web_link
    elif [[ ${libev_v2ray} == "5" ]]; then
        ss_v2ray_ws_tls_web_cdn_link
    fi
}