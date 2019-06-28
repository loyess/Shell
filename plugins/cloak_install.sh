install_cloak(){
    cd ${CUR_DIR}
    chmod +x ${cloak_file}
    mv ${cloak_file} /usr/local/bin/ck-server
    if [ $? -eq 0 ]; then
        echo -e "${Info} Cloak安装成功."
    else
        echo
        echo -e "${Error} Cloak安装失败."
        echo
        install_cleanup
        exit 1
    fi
}