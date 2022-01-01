gen_ss_kcptun_link(){
    local pluginOpt1 pluginOpt2
    local pluginArgs1 pluginArgs2 pluginArgs3 phoneArgs1 phoneArgs2

    clientIpOrDomain="$(get_ip)"
    pluginOpt1="crypt=${crypt};key=${key};mtu=${MTU};sndwnd=${rcvwnd};rcvwnd=${sndwnd}"
    pluginOpt2="mode=${mode};datashard=${datashard};parityshard=${parityshard};dscp=${DSCP}"
    if [[ ${nocomp} == false ]] && [[ ${KP_TCP} == false ]]; then
        clientPluginOpts="${pluginOpt1};${pluginOpt2}"
    elif [[ ${nocomp} == true ]] && [[ ${KP_TCP} == false ]]; then
        clientPluginOpts="${pluginOpt1};${pluginOpt2};nocomp=${nocomp}"
    else
        clientPluginOpts="${pluginOpt1};${pluginOpt2};nocomp=${nocomp};tcp=${KP_TCP}"
    fi
    ss_plugins_client_links

    unset clientPluginOpts
    pluginArgs1="-l %SS_LOCAL_HOST%:%SS_LOCAL_PORT% -r %SS_REMOTE_HOST%:%SS_REMOTE_PORT%"
    pluginArgs2="--crypt ${crypt} --key ${key} --mtu ${MTU} --sndwnd ${rcvwnd} --rcvwnd ${sndwnd}"
    pluginArgs3="--mode ${mode} --datashard ${datashard} --parityshard ${parityshard} --dscp ${DSCP}"
    phoneArgs1="crypt=${crypt};key=${key};mtu=${MTU};sndwnd=${rcvwnd};rcvwnd=${sndwnd}"
    phoneArgs2="mode=${mode};datashard=${datashard};parityshard=${parityshard};dscp=${DSCP}"
    if [[ ${nocomp} == false ]] && [[ ${KP_TCP} == false ]]; then
        clientPluginArgs="${pluginArgs1} ${pluginArgs2} ${pluginArgs3}"
        clientPhoneArgs="${phoneArgs1}${phoneArgs2}"
    elif [[ ${nocomp} == true ]] && [[ ${KP_TCP} == false ]]; then
        clientPluginArgs="${pluginArgs1} ${pluginArgs2} ${pluginArgs3} --nocomp ${nocomp}"
        clientPhoneArgs="${phoneArgs1};${phoneArgs2};nocomp=${nocomp}"
    else
        clientPluginArgs="${pluginArgs1} ${pluginArgs2} ${pluginArgs3} --nocomp ${nocomp} --tcp ${KP_TCP}"
        clientPhoneArgs="${phoneArgs1};${phoneArgs2};nocomp=${nocomp};tcp=${KP_TCP}"
    fi
}