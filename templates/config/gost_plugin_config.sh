# ss + gost-plugin config
ss_gost_plugin_ws_or_mws_config(){
	cat > ${SHADOWSOCKS_CONFIG}<<-EOF
	{
	    "server":${server_value},
	    "server_port":${shadowsocksport},
	    "password":"${shadowsockspwd}",
	    "timeout":300,
	    "user":"nobody",
	    "method":"${shadowsockscipher}",
	    "nameserver":"8.8.8.8",
	    "mode":"tcp_and_udp",
	    "plugin":"gost-plugin",
	    "plugin_opts":"server;path=${path};mode=${mode}"
	}
	EOF
}

ss_gost_plugin_wss_or_mwss_with_cdn_config(){
	cat > ${SHADOWSOCKS_CONFIG}<<-EOF
	{
	    "server":${server_value},
	    "server_port":${shadowsocksport},
	    "password":"${shadowsockspwd}",
	    "timeout":300,
	    "user":"nobody",
	    "method":"${shadowsockscipher}",
	    "nameserver":"8.8.8.8",
	    "mode":"tcp_and_udp",
	    "plugin":"gost-plugin",
	    "plugin_opts":"server;cert=${cerPath};key=${keyPath};path=${path};mode=${mode}"
	}
	EOF
}

ss_gost_plugin_tls_or_mtls_config(){
	cat > ${SHADOWSOCKS_CONFIG}<<-EOF
	{
	    "server":${server_value},
	    "server_port":${shadowsocksport},
	    "password":"${shadowsockspwd}",
	    "timeout":300,
	    "user":"nobody",
	    "method":"${shadowsockscipher}",
	    "nameserver":"8.8.8.8",
	    "mode":"tcp_and_udp",
	    "plugin":"gost-plugin",
	    "plugin_opts":"server;cert=${cerPath};key=${keyPath};mode=${mode}"
	}
	EOF
}

ss_gost_plugin_xtls_config(){
	cat > ${SHADOWSOCKS_CONFIG}<<-EOF
	{
	    "server":${server_value},
	    "server_port":${shadowsocksport},
	    "password":"${shadowsockspwd}",
	    "timeout":300,
	    "user":"nobody",
	    "method":"${shadowsockscipher}",
	    "nameserver":"8.8.8.8",
	    "mode":"tcp_and_udp",
	    "plugin":"gost-plugin",
	    "plugin_opts":"server;cert=${cerPath};key=${keyPath};mode=${mode}"
	}
	EOF
}

ss_gost_plugin_quic_config(){
	cat > ${SHADOWSOCKS_CONFIG}<<-EOF
	{
	    "server":${server_value},
	    "server_port":${shadowsocksport},
	    "password":"${shadowsockspwd}",
	    "timeout":300,
	    "user":"nobody",
	    "method":"${shadowsockscipher}",
	    "nameserver":"8.8.8.8",
	    "mode":"tcp_and_udp",
	    "plugin":"gost-plugin",
	    "plugin_opts":"server;cert=${cerPath};key=${keyPath};mode=${mode}"
	}
	EOF
}

ss_gost_plugin_http2_config(){
	cat > ${SHADOWSOCKS_CONFIG}<<-EOF
	{
	    "server":${server_value},
	    "server_port":${shadowsocksport},
	    "password":"${shadowsockspwd}",
	    "timeout":300,
	    "user":"nobody",
	    "method":"${shadowsockscipher}",
	    "nameserver":"8.8.8.8",
	    "mode":"tcp_and_udp",
	    "plugin":"gost-plugin",
	    "plugin_opts":"server;cert=${cerPath};key=${keyPath};mode=${mode}"
	}
	EOF
}

config_ss_gost_plugin(){
    if [[ ${libev_gost_plugin} = "1" ]]; then
        ss_gost_plugin_ws_or_mws_config
        if [[ ${web_flag} = "1" ]]; then
            improt_package "templates" "caddy_config.sh"
            caddy_config
        elif [[ ${web_flag} = "2" ]]; then
            improt_package "templates" "nginx_config.sh"
            mirror_domain=$(echo ${mirror_site} | sed 's/https:\/\///g')
            nginx_config
        fi
    elif [[ ${libev_gost_plugin} = "2" ]]; then
        ss_gost_plugin_wss_or_mwss_with_cdn_config
    elif [[ ${libev_gost_plugin} = "3" ]]; then
        ss_gost_plugin_tls_or_mtls_config
    elif [[ ${libev_gost_plugin} = "4" ]]; then
        ss_gost_plugin_xtls_config
    elif [[ ${libev_gost_plugin} = "5" ]]; then
        ss_gost_plugin_quic_config
    elif [[ ${libev_gost_plugin} = "6" ]]; then
        ss_gost_plugin_http2_config
    fi
}





























