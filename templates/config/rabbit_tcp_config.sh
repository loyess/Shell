config_ss_rabbit_tcp(){
    if [ ! -d "$(dirname ${RABBIT_CONFIG})" ]; then
        mkdir -p $(dirname ${RABBIT_CONFIG})
    fi
    ss_server_config
    rabbit_tcp_server_config
}