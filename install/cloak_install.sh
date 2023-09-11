install_cloak(){
    cd ${CUR_DIR}
    pushd ${TEMP_DIR_PATH} > /dev/null 2>&1
    chmod +x ${cloak_file}
    mv ${cloak_file} ${CLOAK_SERVER_BIN_PATH}
    if [ $? -eq 0 ]; then
        chmod +x ${CLOAK_INIT}
        local service_name=$(basename ${CLOAK_INIT})
        if check_sys packageManager yum; then
            chkconfig --add ${service_name}
            chkconfig ${service_name} on
        elif check_sys packageManager apt; then
            update-rc.d -f ${service_name} defaults
        fi
        [ -f ${CLOAK_SERVER_BIN_PATH} ] && ln -fs ${CLOAK_SERVER_BIN_PATH} /usr/bin
        _echo -i "Cloak安装成功."
    else
        _echo -e "Cloak安装失败."
        install_cleanup
        exit 1
    fi
    popd > /dev/null 2>&1
}