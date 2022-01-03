install_simple_tls(){
    cd ${CUR_DIR}
    
    if [ ! "$(command -v unzip)" ]; then
        package_install "unzip" > /dev/null 2>&1
    fi
    unzip -oq ${simple_tls_file}.zip
    chmod +x simple-tls
    mv simple-tls ${SIMPLE_TLS_INSTALL_PATH}
    if [ $? -eq 0 ]; then
        [ -f ${SIMPLE_TLS_BIN_PATH} ] && ln -fs ${SIMPLE_TLS_BIN_PATH} /usr/bin
        _echo -i "simple-tls安装成功."
    else
        _echo -e "simple-tls安装失败."
        install_cleanup
        exit 1
    fi
}