# ss + gost-plugin link
ss_gost_plugin_ws_or_mws_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@$(get_ip):${shadowsocksport}/?plugin=${plugin_client_name}"
    local plugin_opts=$(get_str_replace ";path=${path};mode=${mode}")
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

ss_gost_plugin_ws_or_mws_with_web_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@${domain}:${shadowsocksport}/?plugin=${plugin_client_name}"
    local plugin_opts=$(get_str_replace ";serverName=${domain};host=${domain};path=${path};mode=${mode}")
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

ss_gost_plugin_wss_or_mwss_with_cdn_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@${domain}:${shadowsocksport}/?plugin=${plugin_client_name}"
    local plugin_opts=$(get_str_replace ";serverName=${domain};path=${path};mode=${mode}")
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

ss_gost_plugin_tls_or_mtls_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@${domain}:${shadowsocksport}/?plugin=${plugin_client_name}"
    local plugin_opts=$(get_str_replace ";serverName=${domain};mode=${mode}")
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

ss_gost_plugin_xtls_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@${domain}:443/?plugin=${plugin_client_name}"    
    local plugin_opts=$(get_str_replace ";serverName=${domain};mode=${mode}")
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

ss_gost_plugin_quic_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@${domain}:443/?plugin=${plugin_client_name}"    
    local plugin_opts=$(get_str_replace ";serverName=${domain};mode=${mode}")
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

ss_gost_plugin_http2_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@${domain}:443/?plugin=${plugin_client_name}"    
    local plugin_opts=$(get_str_replace ";serverName=${domain};mode=${mode}")
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

gen_ss_gost_plugin_link(){
    if [[ ${libev_gost_plugin} = "1" ]]; then
        if [[ ${isEnableWeb} == enable ]]; then
            if [[ ${mode} == mws ]]; then
                mode=mwss
            elif [[ ${mode} == ws ]]; then
                mode=wss
            fi
            ss_gost_plugin_ws_or_mws_with_web_link
        else
            ss_gost_plugin_ws_or_mws_link
        fi
    elif [[ ${libev_gost_plugin} = "2" ]]; then
        ss_gost_plugin_wss_or_mwss_with_cdn_link
    elif [[ ${libev_gost_plugin} = "3" ]]; then
        ss_gost_plugin_tls_or_mtls_link
    elif [[ ${libev_gost_plugin} = "4" ]]; then
        ss_gost_plugin_xtls_link
    elif [[ ${libev_gost_plugin} = "5" ]]; then
        ss_gost_plugin_quic_link
    elif [[ ${libev_gost_plugin} = "6" ]]; then
        ss_gost_plugin_http2_link
    fi
}