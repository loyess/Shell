install_goquiet(){
    cd ${CUR_DIR}
    chmod +x ${goquiet_file}
    mv ${goquiet_file} ${GOQUIET_BIN_PATH}
    if [ $? -eq 0 ]; then
        [ -f ${GOQUIET_BIN_PATH} ] && ln -fs ${GOQUIET_BIN_PATH} /usr/bin
        echo -e "${Info} GoQuiet安装成功."
    else
        echo
        echo -e "${Error} GoQuiet安装失败."
        echo
        install_cleanup
        exit 1
    fi
}