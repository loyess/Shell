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
        echo -e "${Info} simple-tls安装成功."
    else
        echo
        echo -e "${Error} simple-tls安装失败."
        echo
        install_cleanup
        exit 1
    fi
}