install_rabbit_tcp(){
    cd ${CUR_DIR}
    
    if [ ! "$(command -v gunzip)" ]; then
        package_install "gunzip" > /dev/null 2>&1
    fi
    pushd ${TEMP_DIR_PATH} > /dev/null 2>&1
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
        _echo -i "rabbit-tcp安装成功."
    else
        _echo -e "rabbit-tcp安装失败."
        install_cleanup
        exit 1
    fi
    popd > /dev/null 2>&1
}