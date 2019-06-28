install_kcptun(){
    cd ${CUR_DIR}
    tar zxf ${kcptun_file}.tar.gz
    if [ ! -d "$(dirname ${KCPTUN_INSTALL_DIR})" ]; then
        mkdir -p $(dirname ${KCPTUN_INSTALL_DIR})
    fi
    mv server_linux_amd64 ${KCPTUN_INSTALL_DIR}
    if [ $? -eq 0 ]; then
        chmod +x ${KCPTUN_INIT}
        local service_name=$(basename ${KCPTUN_INIT})
        if check_sys packageManager yum; then
            chkconfig --add ${service_name}
            chkconfig ${service_name} on
        elif check_sys packageManager apt; then
            update-rc.d -f ${service_name} defaults
        fi
        echo -e "${Info} kcptun安装成功."
    else
        echo
        echo -e "${Error} kcptun安装失败."
        echo
        install_cleanup
        exit 1
    fi
    [ -f ${KCPTUN_INSTALL_DIR} ] && ln -s ${KCPTUN_INSTALL_DIR} /usr/bin
    
}