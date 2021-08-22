# ss + goquiet link
ss_goquiet_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@$(get_ip):${shadowsocksport}/?plugin=${plugin_client_name}"    
    local plugin_opts=$(get_str_replace ";ServerName=${domain};Key=${gqkey};TicketTimeHint=3600;Browser=chrome")
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}