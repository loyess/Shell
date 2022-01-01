gen_ss_cloak_link(){
    local pluginOpt1 pluginOpt2

    pluginOpt1="Transport=direct;ProxyMethod=shadowsocks;EncryptionMethod=${encryptionMethod};UID=${ckauid}"
    pluginOpt2="PublicKey=${ckpub};ServerName=${domain};NumConn=${NumConn};BrowserSig=chrome;StreamTimeout=300${AlternativeNames}"
    clientIpOrDomain="$(get_ip)"
    clientPluginOpts="${pluginOpt1};${pluginOpt2}"
    ss_plugins_client_links
}