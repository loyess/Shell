# mos_tls_tunnel
ss_mtt_tls_config(){
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
	    "plugin":"mtt-server",
	    "plugin_opts":"n=${serverName}"
	}
	EOF
}

ss_mtt_tls_dns_only_config(){
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
	    "plugin":"mtt-server",
	    "plugin_opts":"key=${keyPath};cert=${cerPath}"
	}
	EOF
}

ss_mtt_wss_config(){
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
	    "plugin":"mtt-server",
	    "plugin_opts":"wss;wss-path=${wssPath};n=${serverName}"
	}
	EOF
}

ss_mtt_wss_dns_only_or_cdn_config(){
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
	    "plugin":"mtt-server",
	    "plugin_opts":"wss;wss-path=${wssPath};key=${keyPath};cert=${cerPath}"
	}
	EOF
}

ss_mtt_wss_dns_only_or_cdn_web_config(){
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
	    "plugin":"mtt-server",
	    "plugin_opts":"wss;wss-path=${wssPath};disable-tls"
	}
	EOF
}

config_ss_mos_tls_tunnel(){
    if [[ ${libev_mtt} == "1" ]]; then
        if [[ ${domainType} = DNS-Only ]]; then
            ss_mtt_tls_dns_only_config
        else
            ss_mtt_tls_config
        fi
    elif [[ ${libev_mtt} == "2" ]]; then
        if [[ ${isEnableWeb} = disable ]]; then
            ss_mtt_wss_dns_only_or_cdn_config
        elif [[ ${isEnableWeb} = enable ]]; then
            ss_mtt_wss_dns_only_or_cdn_web_config
            domain=${serverName}
            path=${wssPath}
            if [[ ${web_flag} = "1" ]]; then
                improt_package "templates" "caddy_config.sh"
                caddy_config
            elif [[ ${web_flag} = "2" ]]; then
                improt_package "templates" "nginx_config.sh"
                mirror_domain=$(echo ${mirror_site} | sed 's/https:\/\///g')
                nginx_config
            fi 
        else
            ss_mtt_wss_config
        fi
    fi
    
    if [[ ${isEnable} == enable ]]; then
        sed 's/"plugin_opts":"/"plugin_opts":"mux;/' -i ${SHADOWSOCKS_CONFIG}
    fi
}