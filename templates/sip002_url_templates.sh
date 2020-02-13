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
    local plugin_opts=$(get_str_replace ";mode=quic;host=${domain};mux=${mux}")
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
    local plugin_opts=$(get_str_replace ";Transport=direct;ProxyMethod=shadowsocks;EncryptionMethod=plain;UID=${ckauid};PublicKey=${ckpub};ServerName=${domain};NumConn=4;BrowserSig=chrome;StreamTimeout=300")
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}








