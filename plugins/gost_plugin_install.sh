install_gost_plugin(){
    cd ${CUR_DIR}
    
    if [ ! "$(command -v unzip)" ]; then
        package_install "unzip" > /dev/null 2>&1
    fi
    if check_sys packageManager yum; then
        package_install "xz" > /dev/null 2>&1
    elif check_sys packageManager apt; then
        package_install "xz-utils" > /dev/null 2>&1
    fi
    
    unzip -oq ${gost_plugin_file}.zip
    chmod +x gost-plugin
    mv gost-plugin ${GOST_PLUGIN_INSTALL_PATH}
    if [ $? -eq 0 ]; then
        [ -f ${GOST_PLUGIN_BIN_PATH} ] && ln -fs ${GOST_PLUGIN_BIN_PATH} /usr/bin
        echo -e "${Info} gost-plugin安装成功."
    else
        echo
        echo -e "${Error} gost-plugin安装失败."
        echo
        install_cleanup
        exit 1
    fi
}