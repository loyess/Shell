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