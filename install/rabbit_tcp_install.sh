install_rabbit_tcp(){
    cd ${CUR_DIR}
    
    if [ ! "$(command -v gunzip)" ]; then
        package_install "gunzip" > /dev/null 2>&1
    fi
    
    gunzip -q ${rabbit_file}.gz
    chmod +x ${rabbit_file}
    mv ${rabbit_file} ${RABBIT_BIN_PATH}
    if [ $? -eq 0 ]; then
        chmod +x ${RABBIT_INIT}
        local service_name=$(basename ${RABBIT_INIT})
        if check_sys packageManager yum; then
            chkconfig --add ${service_name}
            chkconfig ${service_name} on
        elif check_sys packageManager apt; then
            update-rc.d -f ${service_name} defaults
        fi
        [ -f ${RABBIT_BIN_PATH} ] && ln -fs ${RABBIT_BIN_PATH} /usr/bin
        echo -e "${Info} rabbit-tcp安装成功."
    else
        echo
        echo -e "${Error} rabbit-tcp安装失败."
        echo
        install_cleanup
        exit 1
    fi
}