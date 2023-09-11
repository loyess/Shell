install_kcptun(){
    cd ${CUR_DIR}
    pushd ${TEMP_DIR_PATH} > /dev/null 2>&1
    tar zxf ${kcptun_file}.tar.gz
    if [ ! -d ${KCPTUN_INSTALL_PATH} ]; then
        mkdir -p ${KCPTUN_INSTALL_PATH}
    fi
    mv server_linux_${ARCH} ${KCPTUN_BIN_PATH}
    if [ $? -eq 0 ]; then
        chmod +x ${KCPTUN_INIT}
        local service_name=$(basename ${KCPTUN_INIT})
        if check_sys packageManager yum; then
            chkconfig --add ${service_name}
            chkconfig ${service_name} on
        elif check_sys packageManager apt; then
            update-rc.d -f ${service_name} defaults
        fi
        [ -f ${KCPTUN_BIN_PATH} ] && ln -fs ${KCPTUN_BIN_PATH} /usr/bin
        _echo -i "kcptun安装成功."
    else
        _echo -e "kcptun安装失败."
        install_cleanup
        exit 1
    fi
    popd > /dev/null 2>&1
}