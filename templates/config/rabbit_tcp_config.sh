rabbit_tcp_config_standalone(){
	cat > ${RABBIT_CONFIG}<<-EOF
	{
	    "mode":"s",
	    "rabbit_addr":":${listen_port}",
	    "password":"${rabbitKey}",
	    "verbose":${rabbitLevel}
	}
	EOF
}

config_ss_rabbit_tcp(){
    if [ ! -d "$(dirname ${RABBIT_CONFIG})" ]; then
        mkdir -p $(dirname ${RABBIT_CONFIG})
    fi
    improt_package "templates" "ss_config.sh"
    ss_config_standalone
    rabbit_tcp_config_standalone
}