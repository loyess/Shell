config_ss_cloak(){
    if [ ! -d "$(dirname ${CK_SERVER_CONFIG})" ]; then
        mkdir -p $(dirname ${CK_SERVER_CONFIG})
    fi
    ss_server_config
    cloak_server_config
    cloak_client_config
}