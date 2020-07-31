# ss config
ss_config_standalone(){
	cat > ${SHADOWSOCKS_CONFIG}<<-EOF
	{
	    "server":${server_value},
	    "server_port":${shadowsocksport},
	    "password":"${shadowsockspwd}",
	    "timeout":300,
	    "user":"nobody",
	    "method":"${shadowsockscipher}",
	    "nameserver":"8.8.8.8",
	    "mode":"tcp_and_udp"
	}
	EOF
}