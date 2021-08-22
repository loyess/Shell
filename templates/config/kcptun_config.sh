# kcptun config (Standalone)
kcptun_config_standalone(){
	cat > ${KCPTUN_CONFIG}<<-EOF
	{
	    "listen": ":${listen_port}",
	    "target": "127.0.0.1:${shadowsocksport}",
	    "key": "${key}",
	    "crypt": "${crypt}",
	    "mode": "${mode}",
	    "mtu": ${MTU},
	    "sndwnd": ${sndwnd},
	    "rcvwnd": ${rcvwnd},
	    "datashard": ${datashard},
	    "parityshard": ${parityshard},
	    "dscp": ${DSCP},
	    "nocomp": ${nocomp},
	    "tcp": ${KP_TCP}
	}
	EOF
}

config_ss_kcptun(){
    if [ ! -d "$(dirname ${KCPTUN_CONFIG})" ]; then
        mkdir -p $(dirname ${KCPTUN_CONFIG})
    fi
    improt_package "templates/config" "ss_original_config.sh"
    ss_config_standalone
    kcptun_config_standalone
}