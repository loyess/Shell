get_link_of_ck2(){
    local ckauid=$1
    if [ ${#ckauid} == 24 ] && [ -e '/usr/local/bin/ck-client' ]; then
        local shadowsockscipher=$(cat ${SHADOWSOCKS_LIBEV_CONFIG} | jq -r .method)
        local shadowsockspwd=$(cat ${SHADOWSOCKS_LIBEV_CONFIG} | jq -r .password)
        local ckpub=$(cat ${CK_CLIENT_CONFIG} | jq -r .PublicKey)
        local ckservername=$(cat ${CK_CLIENT_CONFIG} | jq -r .ServerName)
        
        local link_head="ss://"
        local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
        local ip_port_plugin="@$(get_ip):443/?plugin=ck-client"    
        local plugin_opts=$(get_str_replace ";ProxyMethod=shadowsocks;EncryptionMethod=plain;UID=${ckauid};PublicKey=${ckpub};ServerName=${ckservername};NumConn=4;BrowserSig=chrome")
        local ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
        
        echo
        echo -e " ${Green}生成的新用户SS链接：${suffix}"
        echo -e "    ${Red}${ss_link}${suffix}"
        echo
    else
        echo -e " Usage:"
        echo -e "   ./ss-plugins.sh -O link <new add user uid>"
        echo
        echo -e " ${Error} 请检查参数UID是否正确，并且，使用 ./ss-plugins.sh -O uid 添加过新用户..."
        echo
        exit 1
    fi
}