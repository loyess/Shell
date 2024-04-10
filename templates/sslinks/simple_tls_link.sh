gen_ss_simple_tls_link(){
    clientIpOrDomain="$(get_ip)"
    if [ "${modeOptsNumV034}" = "1" ]; then
        if [ "${doYouHaveDomian}" = "No" ]; then
            clientPluginOpts="n=${domain};cca=${base64Cert}${ataArgs}"
        elif [ "${doYouHaveDomian}" = "Yes" ]; then
            clientPluginOpts="n=${domain}${ataArgs}"
        fi
    elif [ "${modeOptsNumV034}" = "2" ]; then
        if [ "${doYouHaveDomian}" = "No" ]; then
            clientPluginOpts="wss;path=${path};n=${domain};cca=${base64Cert}${ataArgs}"
        elif [ "${doYouHaveDomian}" = "Yes" ]; then
            clientPluginOpts="wss;path=${path};n=${domain}${ataArgs}"
        fi
    fi
    if [ "${SimpleTlsVer}" = "2" ]; then
        if [ "${doYouHaveDomian}" = "No" ]; then
            clientPluginOpts="n=${domain};cca=${base64Cert}${ataArgs}"
        elif [ "${doYouHaveDomian}" = "Yes" ]; then
            clientPluginOpts="n=${domain}${ataArgs}"
        fi
    elif [ "${SimpleTlsVer}" = "3" ]; then
        if [ "${doYouHaveDomian}" = "No" ]; then
            if [ "${certificateTypeOptNum}" = "1" ]; then
                clientPluginOpts="n=${domain};no-verify${ataArgs}${wsArgs}${clientMux}"
            elif [ "${certificateTypeOptNum}" = "2" ]; then
                clientPluginOpts="n=${domain};no-verify;cert-hash=${hashCert}${ataArgs}${wsArgs}${clientMux}"
            fi
        elif [ "${doYouHaveDomian}" = "Yes" ]; then
            clientPluginOpts="n=${domain}${ataArgs}${wsArgs}${clientMux}"
        fi
    elif [ "${SimpleTlsVer}" = "4" ]; then
        if [ "${doYouHaveDomian}" = "No" ]; then
            if [ "${certificateTypeOptNum}" = "1" ]; then
                clientPluginOpts="n=${domain};no-verify${grpcArgs}"
            elif [ "${certificateTypeOptNum}" = "2" ]; then
                clientPluginOpts="n=${domain};no-verify;cert-hash=${hashCert}${grpcArgs}"
            fi
        elif [ "${doYouHaveDomian}" = "Yes" ]; then
            clientPluginOpts="n=${domain}${grpcArgs}"
        fi
    fi
    ss_plugins_client_links
}