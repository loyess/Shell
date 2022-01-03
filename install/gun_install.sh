install_gun(){
    cd ${CUR_DIR}
    chmod +x ${gun_file}
    mv ${gun_file} ${GUN_BIN_PATH}
    if [ $? -eq 0 ]; then
        [ -f ${GUN_BIN_PATH} ] && ln -fs ${GUN_BIN_PATH} /usr/bin
        _echo -i "gun安装成功."
    else
        _echo -e "gun安装失败."
        install_cleanup
        exit 1
    fi
}