config_ss_gost_plugin(){
    if [ "${libev_gost_plugin}" = "1" ]; then
        serverPluginOpts="server;path=${path};mode=${mode}"
    elif [ "${libev_gost_plugin}" = "2" ]; then
        serverPluginOpts="server;cert=${cerPath};key=${keyPath};path=${path};mode=${mode}"
    elif [ "${libev_gost_plugin}" = "3" ]; then
        serverPluginOpts="server;cert=${cerPath};key=${keyPath};mode=${mode}"
    elif [ "${libev_gost_plugin}" = "4" ]; then
        serverPluginOpts="server;cert=${cerPath};key=${keyPath};mode=${mode}"
    elif [ "${libev_gost_plugin}" = "5" ]; then
        serverPluginOpts="server;cert=${cerPath};key=${keyPath};mode=${mode}"
    elif [ "${libev_gost_plugin}" = "6" ]; then
        serverPluginOpts="server;cert=${cerPath};key=${keyPath};mode=${mode}"
    elif [ "${libev_gost_plugin}" = "7" ]; then
        serverPluginOpts="server;cert=${cerPath};key=${keyPath};mode=${mode}"
    fi
    ss_plugin_server_config
}