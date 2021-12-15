# ss + qtun config
ss_qtun_config(){
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
	    "plugin":"qtun-server",
	    "plugin_opts":"cert=${cerPath};key=${keyPath}"
	}
	EOF
}

config_ss_qtun(){
    ss_qtun_config
}