# ss + rabbit-tcp
ss_rabbit_tcp_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@$(get_ip):${listen_port}/?plugin=${plugin_client_name}"    
    local plugin_opts=$(get_str_replace ";serviceAddr=$(get_ip):${shadowsocksport};password=${rabbitKey};tunnelN=4")
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"    
}