# ss + xray-plugin link
ss_xray_plugin_ws_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@$(get_ip):${shadowsocksport}/?plugin=${plugin_client_name}"
    local plugin_opts=$(get_str_replace ";path=${path}${muxOption}")
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

ss_xray_plugin_ws_with_web_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@${domain}:${shadowsocksport}/?plugin=${plugin_client_name}"
    local plugin_opts=$(get_str_replace ";tls;host=${domain};path=${path}${muxOption}")
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

ss_xray_plugin_wss_with_cdn_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@${domain}:${shadowsocksport}/?plugin=${plugin_client_name}"
    local plugin_opts=$(get_str_replace ";tls;host=${domain};path=${path}${muxOption}")
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

ss_xray_plugin_quic_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@${domain}:${shadowsocksport}/?plugin=${plugin_client_name}"
    local plugin_opts=$(get_str_replace ";mode=quic;host=${domain}${muxOption}")
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

gen_ss_xray_plugin_link(){
    if [[ ${libev_xray_plugin} = "1" ]]; then
        if [[ ${isEnableWeb} == enable ]]; then
            shadowsocksport=443
            ss_xray_plugin_ws_with_web_link
        else
            ss_xray_plugin_ws_link
        fi
    elif [[ ${libev_xray_plugin} = "2" ]]; then
        ss_xray_plugin_wss_with_cdn_link
    elif [[ ${libev_xray_plugin} = "3" ]]; then
        ss_xray_plugin_quic_link
    fi
}