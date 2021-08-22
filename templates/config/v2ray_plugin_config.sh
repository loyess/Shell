# ss + v2ray-plugin config
ss_v2ray_ws_http_config(){
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
	    "plugin":"v2ray-plugin",
	    "plugin_opts":"server;host=${domain};path=${path}"
	}
	EOF
}

ss_v2ray_ws_tls_cdn_config(){
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
	    "plugin":"v2ray-plugin",
	    "plugin_opts":"server;tls;host=${domain};cert=${cerPath};key=${keyPath};path=${path}"
	}
	EOF
}


ss_v2ray_quic_tls_cdn_config(){
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
	    "plugin":"v2ray-plugin",
	    "plugin_opts":"server;mode=quic;host=${domain};cert=${cerPath};key=${keyPath}"
	}
	EOF
}

ss_v2ray_ws_tls_web_config(){
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
	    "plugin":"v2ray-plugin",
	    "plugin_opts":"server;path=${path}"
	}
	EOF
}

ss_v2ray_ws_tls_web_cdn_config(){
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
	    "plugin":"v2ray-plugin",
	    "plugin_opts":"server;path=${path}"
	}
	EOF
}

config_ss_v2ray_plugin(){
    if [[ ${libev_v2ray} == "1" ]]; then
       ss_v2ray_ws_http_config
    elif [[ ${libev_v2ray} == "2" ]]; then    
       ss_v2ray_ws_tls_cdn_config
    elif [[ ${libev_v2ray} == "3" ]]; then
        ss_v2ray_quic_tls_cdn_config
    elif [[ ${libev_v2ray} == "4" ]]; then
        ss_v2ray_ws_tls_web_config
        if [[ ${web_flag} = "1" ]]; then
            improt_package "templates" "caddy_config.sh"
            caddy_config
        elif [[ ${web_flag} = "2" ]]; then
            improt_package "templates" "nginx_config.sh"
            mirror_domain=$(echo ${mirror_site} | sed 's/https:\/\///g')
            nginx_config
        fi 
    elif [[ ${libev_v2ray} == "5" ]]; then
        ss_v2ray_ws_tls_web_cdn_config
        if [[ ${web_flag} = "1" ]]; then
            improt_package "templates" "caddy_config.sh"
            caddy_config
        elif [[ ${web_flag} = "2" ]]; then
            improt_package "templates" "nginx_config.sh"
            mirror_domain=$(echo ${mirror_site} | sed 's/https:\/\///g')
            nginx_config
        fi 
    fi
    # disable mux
    if [[ ${isDisable} == disable ]] && [[ ${libev_v2ray} != "3" ]]; then
        sed 's/"plugin_opts":"/"plugin_opts":"mux=0;/' -i ${SHADOWSOCKS_CONFIG}
    fi
}