config_ss_kcptun(){
    if [ ! -d "$(dirname ${KCPTUN_CONFIG})" ]; then
        mkdir -p $(dirname ${KCPTUN_CONFIG})
    fi
    ss_server_config
    kcptun_server_config
}