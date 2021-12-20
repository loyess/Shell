# ss + gun config
ss_gun_config(){
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
	    "plugin":"gun-server",
	    "plugin_opts":"${gunPluginOption}"
	}
	EOF
}

config_ss_gun(){
    if [[ ${libev_gun} = "1" ]]; then
        gunPluginOption="server:${cerPath}:${keyPath}"
    elif [[ ${libev_gun} = "2" ]]; then
        gunPluginOption="server:cleartext"
    fi
    ss_gun_config
}