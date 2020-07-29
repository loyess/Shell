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

gen_ss_simple_tls_link(){
    if [[ ${libev_simple_tls} == "1" ]]; then
        ss_simple_tls_link
    elif [[ ${libev_simple_tls} == "2" ]]; then
        ss_simple_tls_wss_link
    fi
}