install_mos_tls_tunnel(){
    cd ${CUR_DIR}
    
    if [ ! "$(command -v unzip)" ]; then
        package_install "unzip" > /dev/null 2>&1
    fi
    pushd ${TEMP_DIR_PATH} > /dev/null 2>&1
    unzip -oq ${mtt_file}.zip
    chmod +x mtt-server
    mv mtt-server ${MTT_BIN_PATH}
    if [ $? -eq 0 ]; then
        [ -f ${MTT_BIN_PATH} ] && ln -fs ${MTT_BIN_PATH} /usr/bin
        _echo -i "mos-tls-tunnel安装成功."
    else
        _echo -e "mos-tls-tunnel安装失败."
        install_cleanup
        exit 1
    fi
    popd > /dev/null 2>&1
}