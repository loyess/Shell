config_ss_gun(){
    if [[ ${libev_gun} = "1" ]]; then
        serverPluginOpts="server:${cerPath}:${keyPath}"
    elif [[ ${libev_gun} = "2" ]]; then
        serverPluginOpts="server:cleartext"
    fi
    ss_plugin_server_config
}