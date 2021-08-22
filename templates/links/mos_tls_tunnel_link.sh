# ss + mos-tls-tunnel
ss_mtt_tls_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@$(get_ip):${shadowsocksport}/?plugin=${plugin_client_name}"
    if [[ ${isEnable} == disable ]]; then
        local plugin_opts=$(get_str_replace ";sv;n=${serverName}")
    elif [[ ${isEnable} == enable ]]; then
        local plugin_opts=$(get_str_replace ";sv;n=${serverName};mux")
    fi
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

ss_mtt_tls_dns_only_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@$(get_ip):${shadowsocksport}/?plugin=${plugin_client_name}"
    if [[ ${isEnable} == disable ]]; then
        local plugin_opts=$(get_str_replace ";n=${serverName}")
    elif [[ ${isEnable} == enable ]]; then
        local plugin_opts=$(get_str_replace ";n=${serverName};mux")
    fi
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

ss_mtt_wss_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@$(get_ip):${shadowsocksport}/?plugin=${plugin_client_name}"
    if [[ ${isEnable} == disable ]]; then
        local plugin_opts=$(get_str_replace ";sv;wss;wss-path=${wssPath};n=${serverName}")
    elif [[ ${isEnable} == enable ]]; then
        local plugin_opts=$(get_str_replace ";sv;wss;wss-path=${wssPath};n=${serverName};mux;mux-max-stream=${muxMaxStream}")
    fi
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

ss_mtt_wss_dns_only_or_cdn_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    if [[ ${domainType} = DNS-Only ]]; then
        local ip_port_plugin="@$(get_ip):${shadowsocksport}/?plugin=${plugin_client_name}"
    elif [[ ${domainType} = CDN ]]; then
        local ip_port_plugin="@${serverName}:${shadowsocksport}/?plugin=${plugin_client_name}"
    fi
    if [[ ${isEnable} == disable ]]; then
        local plugin_opts=$(get_str_replace ";wss;wss-path=${wssPath};n=${serverName}")
    elif [[ ${isEnable} == enable ]]; then
        local plugin_opts=$(get_str_replace ";wss;wss-path=${wssPath};n=${serverName};mux;mux-max-stream=${muxMaxStream}")
    fi
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

ss_mtt_wss_dns_only_or_cdn_web_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    if [[ ${domainType} = DNS-Only ]]; then
        local ip_port_plugin="@$(get_ip):443/?plugin=${plugin_client_name}"
    elif [[ ${domainType} = CDN ]]; then
        local ip_port_plugin="@${serverName}:443/?plugin=${plugin_client_name}"
    fi
    if [[ ${isEnable} == disable ]]; then
        local plugin_opts=$(get_str_replace ";wss;wss-path=${wssPath};n=${serverName}")
    elif [[ ${isEnable} == enable ]]; then
        local plugin_opts=$(get_str_replace ";wss;wss-path=${wssPath};n=${serverName};mux;mux-max-stream=${muxMaxStream}")
    fi
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

gen_ss_mos_tls_tunnel_link(){
    if [[ ${libev_mtt} == "1" ]]; then
        if [[ ${domainType} = DNS-Only ]]; then
            ss_mtt_tls_dns_only_link
        else
            ss_mtt_tls_link
        fi
    elif [[ ${libev_mtt} == "2" ]]; then
        if [[ ${isEnableWeb} = disable ]]; then
            ss_mtt_wss_dns_only_or_cdn_link
        elif [[ ${isEnableWeb} = enable ]]; then
            ss_mtt_wss_dns_only_or_cdn_web_link
        else
            ss_mtt_wss_link
        fi
    fi
}