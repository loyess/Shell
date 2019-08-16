get_link_of_ck(){
    local ckauid=$1
    if [ ${#ckauid} == 44 ] && [ -e '/usr/local/bin/ck-client' ]; then
        local shadowsockscipher=$(cat ${SHADOWSOCKS_LIBEV_CONFIG} | grep -o -P "method\":\".*?\"" | sed 's/method\":\"//g;s/\"//g')
        local shadowsockspwd=$(cat ${SHADOWSOCKS_LIBEV_CONFIG} | grep -o -P "password\":\".*?\"" | sed 's/password\":\"//g;s/\"//g')
        local shadowsocksport=$(cat ${SHADOWSOCKS_LIBEV_CONFIG} | grep -o -P "server_port\":.*?\," | sed 's/server_port\"://g;s/\,//g')
        local ckpub=$(cat ${CK_CLIENT_CONFIG} | grep -o -P "PublicKey\":\".*?\"" | sed 's/PublicKey\":\"//g;s/\"//g')
        local ckservername=$(cat ${CK_CLIENT_CONFIG} | grep -o -P "ServerName\":\".*?\"" | sed 's/ServerName\":\"//g;s/\"//g')
        
        local link_head="ss://"
        local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
        local ip_port_plugin="@$(get_ip):${shadowsocksport}/?plugin=ck-client"
        local plugin_opts=$(get_str_replace ";UID=${ckauid};PublicKey=${ckpub};ServerName=${ckservername};TicketTimeHint=3600;NumConn=4;MaskBrowser=chrome")

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