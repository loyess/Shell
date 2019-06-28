install_goquiet(){
    cd ${CUR_DIR}
    chmod +x ${goquiet_file}
    mv ${goquiet_file} /usr/local/bin/gq-server
    if [ $? -eq 0 ]; then
        echo -e "${Info} GoQuiet安装成功."
    else
        echo
        echo -e "${Error} GoQuiet安装失败."
        echo
        install_cleanup
        exit 1
    fi
}