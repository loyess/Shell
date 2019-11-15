install_cloak(){
    cd ${CUR_DIR}
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
        echo -e "${Info} Cloak安装成功."
    else
        echo
        echo -e "${Error} Cloak安装失败."
        echo
        install_cleanup
        exit 1
    fi
}