install_mos_tls_tunnel(){
    cd ${CUR_DIR}
    
    if [ ! "$(command -v unzip)" ]; then
        package_install "unzip" > /dev/null 2>&1
    fi
    
    unzip -o ${mtt_file}.zip
    chmod +x mtt-server
    mv mtt-server ${MTT_BIN_PATH}
    if [ $? -eq 0 ]; then
        [ -f ${MTT_BIN_PATH} ] && ln -fs ${MTT_BIN_PATH} /usr/bin
        echo -e "${Info} mos-tls-tunnel安装成功."
    else
        echo
        echo -e "${Error} mos-tls-tunnel安装失败."
        echo
        install_cleanup
        exit 1
    fi
}