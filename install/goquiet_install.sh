install_goquiet(){
    cd ${CUR_DIR}
    pushd ${TEMP_DIR_PATH} > /dev/null 2>&1
    chmod +x ${goquiet_file}
    mv ${goquiet_file} ${GOQUIET_BIN_PATH}
    if [ $? -eq 0 ]; then
        [ -f ${GOQUIET_BIN_PATH} ] && ln -fs ${GOQUIET_BIN_PATH} /usr/bin
        _echo -i "GoQuiet安装成功."
    else
        _echo -e "GoQuiet安装失败."
        install_cleanup
        exit 1
    fi
    popd > /dev/null 2>&1
}