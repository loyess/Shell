# ss + goquiet
ss_goquiet_config(){
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
	    "plugin":"gq-server",
	    "plugin_opts":"WebServerAddr=${gqwebaddr};Key=${gqkey}"
	}
	EOF
}