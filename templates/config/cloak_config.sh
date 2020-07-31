# ss + cloak config
cloak2_server_config(){
	cat > ${CK_SERVER_CONFIG}<<-EOF
	{
	    "ProxyBook":{
	    "shadowsocks":["tcp","127.0.0.1:${shadowsocksport}"]
	    },
	    "BindAddr":[":443",":80"],
	    "BypassUID":[],
	    "RedirAddr":"${ckwebaddr}",
	    "PrivateKey":"${ckpv}",
	    "AdminUID":"${ckauid}",
	    "DatabasePath":"${CK_DB_PATH}/userinfo.db",
	    "StreamTimeout":300
	}
	EOF
}

cloak2_client_config(){
	cat > ${CK_CLIENT_CONFIG}<<-EOF
	{
	    "Transport":"direct",
	    "ProxyMethod":"shadowsocks",
	    "EncryptionMethod":"${encryptionMethod}",
	    "UID":"${ckauid}",
	    "PublicKey":"${ckpub}",
	    "ServerName":"${domain}",
	    "NumConn":4,
	    "BrowserSig":"chrome",
	    "StreamTimeout":300
	}
	EOF
}

config_ss_cloak(){
    if [ ! -d "$(dirname ${CK_SERVER_CONFIG})" ]; then
        mkdir -p $(dirname ${CK_SERVER_CONFIG})
    fi
    improt_package "templates/config" "ss_original_config.sh"
    ss_config_standalone
    cloak2_server_config
    cloak2_client_config
}