# ss
ss_link(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port="@$(get_ip):${shadowsocksport}"
    ss_link="${link_head}${cipher_pwd}${ip_port}"
}