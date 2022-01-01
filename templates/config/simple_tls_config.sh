gen_credentials_cca(){

    local domain=$1
    if [ "${doYouHaveDomian}" = "No" ]; then
        cerPath="/etc/simple-tls/${domain}.cert"
        keyPath="/etc/simple-tls/${domain}.key"
        if [ ! -d "$(dirname ${cerPath})" ]; then
            mkdir -p $(dirname ${cerPath})
        fi
        simple-tls -gen-cert -n ${domain} -key ${keyPath} -cert ${cerPath}
        base64Cert=$(cat ${cerPath} | base64 -w0 | sed 's/=//g')
    fi
}

gen_credentials_hash(){
    if [ "${certificateTypeOptNum}" = "2" ]; then
        hashCert=$(simple-tls -hash-cert ${cerPath} | cut -d\  -f2)
    fi
}

config_ss_simple_tls(){
    serverTcpAndUdp="tcp_only"
    gen_credentials_cca "${domain}"
    gen_credentials_hash
    if [ "${modeOptsNumV034}" = "1" ]; then
        serverPluginOpts="s;key=${keyPath};cert=${cerPath}"
    elif [ "${modeOptsNumV034}" = "2" ]; then
        serverPluginOpts="s;wss;path=${path};key=${keyPath};cert=${cerPath}"
    fi
    if [ "${SimpleTlsVer}" = "2" ]; then
        serverPluginOpts="s;key=${keyPath};cert=${cerPath}"
    elif [ "${SimpleTlsVer}" = "3" ]; then
        if [ "${certificateTypeOptNum}" = "1" ]; then
            serverPluginOpts="s;n=${domain}"
        else
            serverPluginOpts="s;key=${keyPath};cert=${cerPath}"
        fi
    fi
    ss_plugin_server_config
    # ata: against traffic analysis
    if [ "${isEnableRh}" = "enable" ]; then
        ataArgs=';rh'
        sed 's/"plugin_opts":"s/"plugin_opts":"s;rh/' -i "${SHADOWSOCKS_CONFIG}"
    elif [ "${isEnablePd}" = "enable" ]; then
        ataArgs=';pd'
        sed 's/"plugin_opts":"s/"plugin_opts":"s;pd/' -i "${SHADOWSOCKS_CONFIG}"
    elif [ "${isEnableAuth}" = "enable" ]; then
        ataArgs=";auth=${auth}"
        sed "s/\"plugin_opts\":\"s/\"plugin_opts\":\"s;auth=${auth}/" -i "${SHADOWSOCKS_CONFIG}"
    fi
}