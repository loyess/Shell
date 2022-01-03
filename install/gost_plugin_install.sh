install_gost_plugin(){
    cd ${CUR_DIR}
    
    if [ ! "$(command -v unzip)" ]; then
        package_install "unzip" > /dev/null 2>&1
    fi
    unzip -oq ${gost_plugin_file}.zip
    chmod +x gost-plugin
    mv gost-plugin ${GOST_PLUGIN_INSTALL_PATH}
    if [ $? -eq 0 ]; then
        [ -f ${GOST_PLUGIN_BIN_PATH} ] && ln -fs ${GOST_PLUGIN_BIN_PATH} /usr/bin
        _echo -i "gost-plugin安装成功."
    else
        _echo -e "gost-plugin安装失败."
        install_cleanup
        exit 1
    fi
}