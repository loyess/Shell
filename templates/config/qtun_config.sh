config_ss_qtun(){
    serverTcpAndUdp="tcp_only"
    serverPluginOpts="cert=${cerPath};key=${keyPath}"
    ss_plugin_server_config
}