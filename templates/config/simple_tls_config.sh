# simple-tls
ss_simple_tls_config(){
	cat > ${SHADOWSOCKS_CONFIG}<<-EOF
	{
	    "server":${server_value},
	    "server_port":${shadowsocksport},
	    "password":"${shadowsockspwd}",
	    "timeout":300,
	    "user":"nobody",
	    "method":"${shadowsockscipher}",
	    "nameserver":"8.8.8.8",
	    "mode":"tcp_only",
	    "plugin":"simple-tls",
	    "plugin_opts":"s;key=${keyPath};cert=${cerPath}"
	}
	EOF
}

ss_simple_tls_wss_config(){
	cat > ${SHADOWSOCKS_CONFIG}<<-EOF
	{
	    "server":${server_value},
	    "server_port":${shadowsocksport},
	    "password":"${shadowsockspwd}",
	    "timeout":300,
	    "user":"nobody",
	    "method":"${shadowsockscipher}",
	    "nameserver":"8.8.8.8",
	    "mode":"tcp_only",
	    "plugin":"simple-tls",
	    "plugin_opts":"s;wss;path=${wssPath};key=${keyPath};cert=${cerPath}"
	}
	EOF
}

config_ss_simple_tls(){
    if [[ ${libev_simple_tls} == "1" ]]; then
        ss_simple_tls_config
    elif [[ ${libev_simple_tls} == "2" ]]; then
        ss_simple_tls_wss_config
    fi

    if [[ ${SimpleTlsVer} = "1" ]] && [[ ${isEnable} == enable ]]; then
        sed 's/"plugin_opts":"s/"plugin_opts":"s;rh/' -i ${SHADOWSOCKS_CONFIG}
    elif [[ ${SimpleTlsVer} = "2" ]] && [[ ${isEnable} == enable ]]; then
        sed 's/"plugin_opts":"s/"plugin_opts":"s;pd/' -i ${SHADOWSOCKS_CONFIG}
    fi
}