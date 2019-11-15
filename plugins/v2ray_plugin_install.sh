install_v2ray_plugin(){
    cd ${CUR_DIR}
    tar zxf ${v2ray_plugin_file}.tar.gz
    if [ ! -d ${V2RAY_PLUGIN_INSTALL_PATH} ]; then
        mkdir -p ${V2RAY_PLUGIN_INSTALL_PATH}
    fi
    mv v2ray-plugin_linux_amd64 ${V2RAY_PLUGIN_BIN_PATH}
    if [ $? -eq 0 ]; then
        echo -e "${Info} v2ray-plugin安装成功."
    else
        echo
        echo -e "${Error} v2ray-plugin安装失败."
        echo
        install_cleanup
        exit 1
    fi
}