install_xray_plugin(){
    cd ${CUR_DIR}
    pushd ${TEMP_DIR_PATH} > /dev/null 2>&1
    tar zxf ${xray_plugin_file}.tar.gz
    if [ ! -d ${XRAY_PLUGIN_INSTALL_PATH} ]; then
        mkdir -p ${XRAY_PLUGIN_INSTALL_PATH}
    fi
    mv xray-plugin_linux_${ARCH} ${XRAY_PLUGIN_BIN_PATH}
    if [ $? -eq 0 ]; then
        [ -f ${XRAY_PLUGIN_BIN_PATH} ] && ln -fs ${XRAY_PLUGIN_BIN_PATH} /usr/bin
        _echo -i "xray-plugin安装成功."
    else
        _echo -e "xray-plugin安装失败."
        install_cleanup
        exit 1
    fi
    popd > /dev/null 2>&1
}