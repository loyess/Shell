install_qtun(){
    cd ${CUR_DIR}
    tar xf ${qtun_file}.tar.xz
    if [ ! -d ${QTUN_INSTALL_PATH} ]; then
        mkdir -p ${QTUN_INSTALL_PATH}
    fi
    mv qtun-server ${QTUN_BIN_PATH}
    if [ $? -eq 0 ]; then
        [ -f ${QTUN_BIN_PATH} ] && ln -fs ${QTUN_BIN_PATH} /usr/bin
        _echo -i "qtun安装成功."
    else
        _echo -e "qtun安装失败."
        install_cleanup
        exit 1
    fi
}