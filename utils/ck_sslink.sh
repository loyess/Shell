get_link_of_ck2(){
    local ckauid=$1
    if [ ${#ckauid} == 24 ] && [ -e ${CLOAK_CLIENT_BIN_PATH} ]; then
        local shadowsockscipher=$(cat ${SHADOWSOCKS_CONFIG} | jq -r .method)
        local shadowsockspwd=$(cat ${SHADOWSOCKS_CONFIG} | jq -r .password)
        local ckpub=$(cat ${CK_CLIENT_CONFIG} | jq -r .PublicKey)
        local ckservername=$(cat ${CK_CLIENT_CONFIG} | jq -r .ServerName)
        local encryptionMethod=$(cat ${CK_CLIENT_CONFIG} | jq -r .EncryptionMethod)
        local clientport=$(cat ${CK_SERVER_CONFIG} | jq .BindAddr | grep -o '[0-9]\+' | head -n 1)
        
        local link_head="ss://"
        local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
        local ip_port_plugin="@$(get_ip):${clientport}/?plugin=ck-client"
        local plugin_opts=$(url_encode ";Transport=direct;ProxyMethod=shadowsocks;EncryptionMethod=${encryptionMethod};UID=${ckauid};PublicKey=${ckpub};ServerName=${ckservername};NumConn=4;BrowserSig=chrome;StreamTimeout=300")
        local ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
        
        echo
        echo -e " ${Green}生成的新用户SS链接：${suffix}"
        echo -e "    ${Red}${ss_link}${suffix}"
        echo
    else
        echo -e " Usage:"
        echo -e "   ./ss-plugins.sh link <new add user uid>"
        echo
        echo -e " ${Error} 请检查参数UID是否正确，并且，使用 ./ss-plugins.sh uid 添加过新用户."
        echo
        exit 1
    fi
}

gen_ssurl_by_uid(){
    local CK_UID=$1

    if [ ! "$(command -v ck-server)" ]; then
        echo -e "\n${Error} 仅支持 ss + cloak 组合下使用，请确认是否是以该组合形式运行.\n"
        exit 1
    fi

    get_link_of_ck2 "${CK_UID}"
}