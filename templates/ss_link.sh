# ss
ss_link(){
    local tmp=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}@$(get_ip):${shadowsocksport}")
    ss_link="ss://${tmp}"
}