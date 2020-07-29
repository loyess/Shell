# ss + cloak link
ss_cloak_link_new(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@$(get_ip):443/?plugin=${plugin_client_name}"    
    local plugin_opts=$(get_str_replace ";Transport=direct;ProxyMethod=shadowsocks;EncryptionMethod=${encryptionMethod};UID=${ckauid};PublicKey=${ckpub};ServerName=${domain};NumConn=4;BrowserSig=chrome;StreamTimeout=300")
    ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
}