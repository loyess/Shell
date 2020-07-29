# ss + simple-obfs
ss_obfs_http_config(){
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
	    "plugin":"obfs-server",
	    "plugin_opts":"obfs=${shadowsocklibev_obfs}"
	}
	EOF
}

ss_obfs_tls_config(){
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
	    "plugin":"obfs-server",
	    "plugin_opts":"obfs=${shadowsocklibev_obfs}"
	}
	EOF
}


config_ss_simple_obfs(){
    if [[ ${libev_obfs} == "1" ]]; then
       ss_obfs_http_config
    elif [[ ${libev_obfs} == "2" ]]; then    
       ss_obfs_tls_config
    fi
}