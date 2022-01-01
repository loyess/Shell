install_xray_plugin(){
    cd ${CUR_DIR}
    tar zxf ${xray_plugin_file}.tar.gz
    if [ ! -d ${XRAY_PLUGIN_INSTALL_PATH} ]; then
        mkdir -p ${XRAY_PLUGIN_INSTALL_PATH}
    fi
    mv xray-plugin_linux_${ARCH} ${XRAY_PLUGIN_BIN_PATH}
    if [ $? -eq 0 ]; then
        [ -f ${XRAY_PLUGIN_BIN_PATH} ] && ln -fs ${XRAY_PLUGIN_BIN_PATH} /usr/bin
        echo -e "${Info} xray-plugin安装成功."
    else
        echo
        echo -e "${Error} xray-plugin安装失败."
        echo
        install_cleanup
        exit 1
    fi
}