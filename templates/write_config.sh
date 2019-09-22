# ss config
ss_config_standalone(){
	cat > ${SHADOWSOCKS_LIBEV_CONFIG}<<-EOF
	{
		"server":${server_value},
		"server_port":${shadowsocksport},
		"password":"${shadowsockspwd}",
		"timeout":300,
		"user":"nobody",
		"method":"${shadowsockscipher}",
		"fast_open":${fast_open},
		"nameserver":"8.8.8.8",
		"mode":"tcp_and_udp"
	}
	EOF
}

# ss + v2ray-plugin config
ss_v2ray_ws_http_config(){
	cat > ${SHADOWSOCKS_LIBEV_CONFIG}<<-EOF
	{
		"server":${server_value},
		"server_port":${shadowsocksport},
		"password":"${shadowsockspwd}",
		"timeout":300,
		"user":"nobody",
		"method":"${shadowsockscipher}",
		"fast_open":${fast_open},
		"nameserver":"8.8.8.8",
		"mode":"tcp_and_udp",
		"plugin":"v2ray-plugin",
		"plugin_opts":"server"
	}
	EOF
}

ss_v2ray_ws_tls_cdn_config(){
	cat > ${SHADOWSOCKS_LIBEV_CONFIG}<<-EOF
	{
		"server":${server_value},
		"server_port":${shadowsocksport},
		"password":"${shadowsockspwd}",
		"timeout":300,
		"user":"nobody",
		"method":"${shadowsockscipher}",
		"fast_open":${fast_open},
		"nameserver":"8.8.8.8",
		"mode":"tcp_and_udp",
		"plugin":"v2ray-plugin",
		"plugin_opts":"server;tls;host=${domain};cert=${cerpath};key=${keypath}"
	}
	EOF
}


ss_v2ray_quic_tls_cdn_config(){
	cat > ${SHADOWSOCKS_LIBEV_CONFIG}<<-EOF
	{
		"server":${server_value},
		"server_port":${shadowsocksport},
		"password":"${shadowsockspwd}",
		"timeout":300,
		"user":"nobody",
		"method":"${shadowsockscipher}",
		"fast_open":${fast_open},
		"nameserver":"8.8.8.8",
		"mode":"tcp_only",
		"plugin":"v2ray-plugin",
		"plugin_opts":"server;mode=quic;host=${domain};cert=${cerpath};key=${keypath}"
	}
	EOF
}

ss_v2ray_ws_tls_web_config(){
	cat > ${SHADOWSOCKS_LIBEV_CONFIG}<<-EOF
	{
		"server":${server_value},
		"server_port":${shadowsocksport},
		"password":"${shadowsockspwd}",
		"timeout":300,
		"user":"nobody",
		"method":"${shadowsockscipher}",
		"fast_open":${fast_open},
		"nameserver":"8.8.8.8",
		"mode":"tcp_and_udp",
		"plugin":"v2ray-plugin",
		"plugin_opts":"server;path=${path};loglevel=none"
	}
	EOF
}

caddy_config_none_cdn(){
	cat > ${CADDY_CONF_FILE}<<-EOF
	${domain}:443 {
		gzip
		tls ${email}
		timeouts none
		proxy ${path} localhost:${shadowsocksport} {
			websocket
			header_upstream -Origin
		}
		proxy / ${mirror_site} {
			except ${path}
		}
	}
	EOF
}

ss_v2ray_ws_tls_web_cdn_config(){
	cat > ${SHADOWSOCKS_LIBEV_CONFIG}<<-EOF
	{
		"server":${server_value},
		"server_port":${shadowsocksport},
		"password":"${shadowsockspwd}",
		"timeout":300,
		"user":"nobody",
		"method":"${shadowsockscipher}",
		"fast_open":${fast_open},
		"nameserver":"8.8.8.8",
		"mode":"tcp_and_udp",
		"plugin":"v2ray-plugin",
		"plugin_opts":"server;path=${path};loglevel=none"
	}
	EOF
}

caddy_config_with_cdn(){
	cat > ${CADDY_CONF_FILE}<<-EOF
	${domain}:443 {
		gzip
		tls {
			dns cloudflare
		}
		timeouts none
		proxy ${path} localhost:${shadowsocksport} {
			websocket
			header_upstream -Origin
		}
		proxy / ${mirror_site} {
			except ${path}
		}
	}
	EOF
}

# kcptun config (Standalone)
kcptun_config_standalone(){
	cat > ${KCPTUN_CONFIG}<<-EOF
	{
		"listen": ":${listen_port}",
		"target": "${target_addr}:${target_port}",
		"key": "${key}",
		"crypt": "${crypt}",
		"mode": "${mode}",
		"mtu": ${MTU},
		"sndwnd": ${sndwnd},
		"rcvwnd": ${rcvwnd},
		"datashard": ${datashard},
		"parityshard": ${parityshard},
		"dscp": ${DSCP},
		"nocomp": ${nocomp}
	}
	EOF
}

# ss + simple-obfs
ss_obfs_http_config(){
	cat > ${SHADOWSOCKS_LIBEV_CONFIG}<<-EOF
	{
		"server":${server_value},
		"server_port":${shadowsocksport},
		"password":"${shadowsockspwd}",
		"timeout":300,
		"user":"nobody",
		"method":"${shadowsockscipher}",
		"fast_open":${fast_open},
		"nameserver":"8.8.8.8",
		"mode":"tcp_and_udp",
		"plugin":"obfs-server",
		"plugin_opts":"obfs=${shadowsocklibev_obfs}"
	}
	EOF
}

ss_obfs_tls_config(){
	cat > ${SHADOWSOCKS_LIBEV_CONFIG}<<-EOF
	{
		"server":${server_value},
		"server_port":${shadowsocksport},
		"password":"${shadowsockspwd}",
		"timeout":300,
		"user":"nobody",
		"method":"${shadowsockscipher}",
		"fast_open":${fast_open},
		"nameserver":"8.8.8.8",
		"mode":"tcp_and_udp",
		"plugin":"obfs-server",
		"plugin_opts":"obfs=${shadowsocklibev_obfs}"
	}
	EOF
}

# ss + goquiet
ss_goquiet_config(){
	cat > ${SHADOWSOCKS_LIBEV_CONFIG}<<-EOF
	{
		"server":${server_value},
		"server_port":${shadowsocksport},
		"password":"${shadowsockspwd}",
		"timeout":300,
		"user":"nobody",
		"method":"${shadowsockscipher}",
		"fast_open":${fast_open},
		"nameserver":"8.8.8.8",
		"mode":"tcp_and_udp",
		"plugin":"gq-server",
		"plugin_opts":"WebServerAddr=${gqwebaddr};Key=${gqkey}"
	}
	EOF
}

# ss + cloak config
cloak2_server_config(){
	cat > ${CK_SERVER_CONFIG}<<-EOF
	{
		"ProxyBook":{
		"shadowsocks":"127.0.0.1:${shadowsocksport}"
		},
		"BypassUID":[],
		"RedirAddr":"${ckwebaddr}",
		"PrivateKey":"${ckpv}",
		"AdminUID":"${ckauid}",
		"DatabasePath":"${ckdbp}/userinfo.db"
	}
	EOF
}

cloak2_client_config(){
	cat > ${CK_CLIENT_CONFIG}<<-EOF
	{
		"ProxyMethod":"shadowsocks",
		"EncryptionMethod":"plain",
		"UID":"${ckauid}",
		"PublicKey":"${ckpub}",
		"ServerName":"${domain}",
		"NumConn":4,
		"BrowserSig":"chrome"
	}
	EOF
}












