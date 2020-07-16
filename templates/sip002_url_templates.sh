# ss
ss_link(){
    local tmp=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}@$(get_ip):${shadowsocksport}")
    ss_link="ss://${tmp}"
}

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

# ss + kcptun link
ss_kcptun_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@$(get_ip):${listen_port}/?plugin=${plugin_client_name}"    
    if [[ ${nocomp} == false ]] && [[ ${KP_TCP} == false ]]; then
        local plugin_opts=$(get_str_replace ";crypt=${crypt};key=${key};mtu=${MTU};sndwnd=${rcvwnd};rcvwnd=${sndwnd};mode=${mode};datashard=${datashard};parityshard=${parityshard};dscp=${DSCP}")
    elif [[ ${nocomp} == true ]] && [[ ${KP_TCP} == false ]]; then
        local plugin_opts=$(get_str_replace ";crypt=${crypt};key=${key};mtu=${MTU};sndwnd=${rcvwnd};rcvwnd=${sndwnd};mode=${mode};datashard=${datashard};parityshard=${parityshard};dscp=${DSCP};nocomp=${nocomp}")
    else
        local plugin_opts=$(get_str_replace ";crypt=${crypt};key=${key};mtu=${MTU};sndwnd=${rcvwnd};rcvwnd=${sndwnd};mode=${mode};datashard=${datashard};parityshard=${parityshard};dscp=${DSCP};nocomp=${nocomp};tcp=${KP_TCP}")
    fi
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

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

# ss + goquiet link
ss_goquiet_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@$(get_ip):${shadowsocksport}/?plugin=${plugin_client_name}"    
    local plugin_opts=$(get_str_replace ";ServerName=${domain};Key=${gqkey};TicketTimeHint=3600;Browser=chrome")
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

# ss + cloak link
ss_cloak_link_new(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@$(get_ip):443/?plugin=${plugin_client_name}"    
    local plugin_opts=$(get_str_replace ";Transport=direct;ProxyMethod=shadowsocks;EncryptionMethod=${encryptionMethod};UID=${ckauid};PublicKey=${ckpub};ServerName=${domain};NumConn=4;BrowserSig=chrome;StreamTimeout=300")
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

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

# ss + rabbit-tcp
ss_rabbit_tcp_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@$(get_ip):${listen_port}/?plugin=${plugin_client_name}"    
    local plugin_opts=$(get_str_replace ";serviceAddr=$(get_ip):${shadowsocksport};password=${rabbitKey};tunnelN=4")
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"    
}

# ss + simple-tls
ss_simple_tls_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@$(get_ip):443/?plugin=${plugin_client_name}"
    if [[ ${isEnable} == disable ]]; then
        local ataArgs=''
    elif [[ ${SimpleTlsVer} = "1" ]] && [[ ${isEnable} == enable ]]; then
        local ataArgs=';rh'
    elif [[ ${SimpleTlsVer} = "2" ]] && [[ ${isEnable} == enable ]]; then
        local ataArgs=';pd'
    fi
    if [[ ${domainType} = DNS-Only ]]; then
        local plugin_opts=$(get_str_replace "${ataArgs};n=${serverName}")
    elif [[ ${domainType} = Other ]]; then
        local plugin_opts=$(get_str_replace "${ataArgs};n=${serverName};cca=${base64Cert}")
    fi
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}

ss_simple_tls_wss_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    if [[ ${domainType} = CDN ]]; then
        local ip_port_plugin="@${serverName}:443/?plugin=${plugin_client_name}"
    else
        local ip_port_plugin="@$(get_ip):443/?plugin=${plugin_client_name}"
    fi
    if [[ ${isEnable} == disable ]]; then
        local ataArgs=''
    elif [[ ${isEnable} == enable ]]; then
        local ataArgs=';rh'
    fi
    if [[ ${domainType} = DNS-Only ]] || [[ ${domainType} = CDN ]]; then
        local plugin_opts=$(get_str_replace "${ataArgs};wss;path=${wssPath};n=${serverName}")
    elif [[ ${domainType} = Other ]]; then
        local plugin_opts=$(get_str_replace "${ataArgs};wss;path=${wssPath};n=${serverName};cca=${base64Cert}")
    fi
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}






